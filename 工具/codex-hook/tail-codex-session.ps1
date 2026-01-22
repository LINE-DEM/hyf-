param(
  [Parameter(Mandatory = $true)]
  [datetime]$StartTime,

  [Parameter(Mandatory = $true)]
  [string]$Cwd,

  [Parameter(Mandatory = $true)]
  [string]$LogDir,

  [int]$PollMs = 500
)

$ErrorActionPreference = "Stop"

function Get-LatestRolloutFile([datetime]$StartTime, [string]$Cwd) {
  $root = Join-Path $env:USERPROFILE ".codex\\sessions"
  if (-not (Test-Path $root)) { return $null }

  $candidates =
    Get-ChildItem -Recurse -Force $root -Filter "rollout-*.jsonl" -ErrorAction SilentlyContinue |
    Where-Object { $_.LastWriteTime -ge $StartTime.AddMinutes(-1) } |
    Sort-Object LastWriteTime -Descending

  foreach ($f in $candidates) {
    try {
      $first = Get-Content -Encoding UTF8 -TotalCount 2 -Path $f.FullName -ErrorAction Stop
      if ($first.Count -lt 1) { continue }
      $meta = $first[0] | ConvertFrom-Json -ErrorAction Stop
      if ($meta.type -ne "session_meta") { continue }
      if ($meta.payload.cwd -and $Cwd -and $meta.payload.cwd -ne $Cwd) { continue }
      return $f.FullName
    } catch {
      continue
    }
  }
  return $null
}

function Get-ContentText($contentArray) {
  if (-not $contentArray) { return "" }
  $parts = New-Object System.Collections.Generic.List[string]
  foreach ($c in $contentArray) {
    if ($null -ne $c.text -and ($c.text -is [string]) -and $c.text.Length -gt 0) {
      $parts.Add($c.text) | Out-Null
    }
  }
  return ($parts -join "`n")
}

function Is-HarnessMetaUserText([string]$text) {
  if ([string]::IsNullOrWhiteSpace($text)) { return $true }
  $t = $text.TrimStart()
  return (
    $t.StartsWith("# AGENTS.md instructions", [System.StringComparison]::OrdinalIgnoreCase) -or
    $t.StartsWith("<environment_context>", [System.StringComparison]::OrdinalIgnoreCase) -or
    $t.StartsWith("<skill>", [System.StringComparison]::OrdinalIgnoreCase) -or
    $t.StartsWith("<INSTRUCTIONS>", [System.StringComparison]::OrdinalIgnoreCase)
  )
}

if (-not (Test-Path $LogDir)) {
  New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
}

$rollout = $null
while (-not $rollout) {
  $rollout = Get-LatestRolloutFile -StartTime $StartTime -Cwd $Cwd
  if (-not $rollout) { Start-Sleep -Milliseconds $PollMs }
}

$dateDir = Join-Path $LogDir (Get-Date -Format "yyyy-MM-dd")
New-Item -ItemType Directory -Force -Path $dateDir | Out-Null

$tmpOut = Join-Path $dateDir ("codex_live_" + (Get-Date -Format "yyyy-MM-dd_HHmmss") + ".md")
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
$currentOut = $tmpOut
$writer = New-Object System.IO.StreamWriter($currentOut, $true, $utf8Bom)
$writer.NewLine = "`r`n"

$sessionId = $null
$headerWritten = $false
$turn = 0
$lastRole = $null

function Ensure-Header([System.IO.StreamWriter]$writer, [string]$sessionId, [string]$cwd, [string]$startedAt) {
  $writer.WriteLine("# Codex Chat Log")
  $writer.WriteLine()
  if ($sessionId) { $writer.WriteLine("- session_id: $sessionId") }
  if ($cwd) { $writer.WriteLine("- cwd: $cwd") }
  if ($startedAt) { $writer.WriteLine("- started_at: $startedAt") }
  $writer.WriteLine()
  $writer.Flush()
}

function Reopen-Writer([string]$path) {
  if ($script:writer) {
    try { $script:writer.Flush() } catch {}
    try { $script:writer.Dispose() } catch {}
    $script:writer = $null
  }
  $script:writer = New-Object System.IO.StreamWriter($path, $true, $script:utf8Bom)
  $script:writer.NewLine = "`r`n"
  $script:writer.Flush()
}

function Process-JsonLine($obj) {
  if ($obj.type -eq "session_meta") {
    if (-not $script:sessionId) { $script:sessionId = $obj.payload.id }
    if (-not $script:headerWritten) {
      Ensure-Header -writer $script:writer -sessionId $script:sessionId -cwd $obj.payload.cwd -startedAt $obj.payload.timestamp
      $script:headerWritten = $true
    }

    if ($script:sessionId -and ($script:currentOut -like "*codex_live_*")) {
      $finalOut = Join-Path $dateDir ("codex_" + (Get-Date -Format "yyyy-MM-dd_HHmmss") + "_" + $script:sessionId + ".md")
      try {
        if ($script:writer) {
          try { $script:writer.Flush() } catch {}
          try { $script:writer.Dispose() } catch {}
          $script:writer = $null
        }
        Move-Item -Force -Path $script:currentOut -Destination $finalOut
        $script:currentOut = $finalOut
        Reopen-Writer -path $script:currentOut
      } catch {
        # keep using live path
        Reopen-Writer -path $script:currentOut
      }
    }
    return
  }

  # Preferred format: event_msg payload.type = user_message|agent_message, payload.message = string
  if ($obj.type -ne "event_msg") { return }
  if ($null -eq $obj.payload) { return }
  $ptype = $obj.payload.type
  if ($ptype -ne "user_message" -and $ptype -ne "agent_message") { return }

  $text = $obj.payload.message
  if (-not ($text -is [string])) { return }
  if ($ptype -eq "user_message" -and (Is-HarnessMetaUserText -text $text)) { return }

  if (-not $script:headerWritten) {
    Ensure-Header -writer $script:writer -sessionId $script:sessionId -cwd $Cwd -startedAt ""
    $script:headerWritten = $true
  }

  if ($ptype -eq "user_message") {
    $script:turn++
    $script:writer.WriteLine("## Turn $($script:turn)")
    $script:writer.WriteLine()
    $script:writer.WriteLine("### User")
    $script:writer.WriteLine()
    $script:writer.WriteLine($text)
    $script:writer.WriteLine()
    $script:lastRole = "user"
    $script:writer.Flush()
    return
  }

  if ($ptype -eq "agent_message") {
    if ($script:turn -eq 0) { $script:turn = 1; $script:writer.WriteLine("## Turn $($script:turn)"); $script:writer.WriteLine() }
    if ($script:lastRole -ne "assistant") {
      $script:writer.WriteLine("### Assistant")
      $script:writer.WriteLine()
    }
    $script:writer.WriteLine($text)
    $script:writer.WriteLine()
    $script:lastRole = "assistant"
    $script:writer.Flush()
    return
  }
}

function Read-AllLinesShared([string]$Path) {
  $utf8Strict = New-Object System.Text.UTF8Encoding($false, $true)
  $fileStream = $null
  $reader = $null
  try {
    $fileStream = [System.IO.File]::Open($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    $reader = New-Object System.IO.StreamReader($fileStream, $utf8Strict, $true)
    $lines = New-Object System.Collections.Generic.List[string]
    while (-not $reader.EndOfStream) {
      $lines.Add($reader.ReadLine()) | Out-Null
    }
    return ,$lines.ToArray()
  } finally {
    if ($reader) { $reader.Dispose() }
    if ($fileStream) { $fileStream.Dispose() }
  }
}

function Follow-LinesShared([string]$Path, [int]$PollMs) {
  $utf8Strict = New-Object System.Text.UTF8Encoding($false, $true)
  $fileStream = $null
  $reader = $null
  try {
    $fileStream = [System.IO.File]::Open($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    $reader = New-Object System.IO.StreamReader($fileStream, $utf8Strict, $true)

    while ($true) {
      $line = $reader.ReadLine()
      if ($null -ne $line) {
        $line
        continue
      }

      Start-Sleep -Milliseconds $PollMs
      $reader.DiscardBufferedData()
    }
  } finally {
    if ($reader) { $reader.Dispose() }
    if ($fileStream) { $fileStream.Dispose() }
  }
}

try {
  Follow-LinesShared -Path $rollout -PollMs $PollMs | ForEach-Object {
    $line = $_
    if ([string]::IsNullOrWhiteSpace($line)) { return }
    $obj = $null
    try { $obj = $line | ConvertFrom-Json -ErrorAction Stop } catch { return }
    Process-JsonLine -obj $obj
  }
} finally {
  if ($script:writer) {
    try { $script:writer.Flush() } catch {}
    try { $script:writer.Dispose() } catch {}
  }
  Write-Output $currentOut
}
