param(
  [Parameter(Mandatory = $true)]
  [string]$RolloutPath,

  [Parameter(Mandatory = $true)]
  [string]$OutDir,

  [string]$OutFileName
)

$ErrorActionPreference = "Stop"

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

$lines = Read-AllLinesShared -Path $RolloutPath

$sessionId = $null
$sessionCwd = $null
$sessionTimestamp = $null

$eventMessages = New-Object System.Collections.Generic.List[object]
$fallbackMessages = New-Object System.Collections.Generic.List[object]

foreach ($line in $lines) {
  if ([string]::IsNullOrWhiteSpace($line)) { continue }
  $obj = $null
  try {
    $obj = $line | ConvertFrom-Json -ErrorAction Stop
  } catch {
    continue
  }

  if ($obj.type -eq "session_meta") {
    $sessionId = $obj.payload.id
    $sessionCwd = $obj.payload.cwd
    $sessionTimestamp = $obj.payload.timestamp
    continue
  }

  # Preferred format: event_msg payload.type = user_message|agent_message, payload.message = string
  if ($obj.type -eq "event_msg" -and $null -ne $obj.payload) {
    $ptype = $obj.payload.type
    if ($ptype -eq "user_message" -or $ptype -eq "agent_message") {
      $text = $obj.payload.message
      if (-not ($text -is [string])) { continue }
      if ($ptype -eq "user_message" -and (Is-HarnessMetaUserText -text $text)) { continue }

      $eventMessages.Add([pscustomobject]@{
        timestamp = $obj.timestamp
        role      = $(if ($ptype -eq "user_message") { "user" } else { "assistant" })
        text      = $text
      }) | Out-Null
      continue
    }
  }

  # Fallback (older): response_item payload.type=message, payload.role=user|assistant, payload.content[].text
  if ($obj.type -ne "response_item") { continue }
  if ($null -eq $obj.payload) { continue }
  if ($obj.payload.type -ne "message") { continue }
  if ($obj.payload.role -ne "user" -and $obj.payload.role -ne "assistant") { continue }

  $text = Get-ContentText -contentArray $obj.payload.content
  if ($obj.payload.role -eq "user" -and (Is-HarnessMetaUserText -text $text)) { continue }

  $fallbackMessages.Add([pscustomobject]@{
    timestamp = $obj.timestamp
    role      = $obj.payload.role
    text      = $text
  }) | Out-Null
}

$messages =
  if ($eventMessages.Count -gt 0) { $eventMessages }
  else { $fallbackMessages }

if (-not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
}

if (-not $OutFileName) {
  $ts = Get-Date -Format "yyyy-MM-dd_HHmmss"
  $idPart = if ($sessionId) { $sessionId } else { "unknown-session" }
  $OutFileName = "codex_${ts}_${idPart}.md"
}

$outPath = Join-Path $OutDir $OutFileName

$md = New-Object System.Collections.Generic.List[string]
$md.Add("# Codex Chat Log") | Out-Null
$md.Add("") | Out-Null
if ($sessionId) { $md.Add("- session_id: $sessionId") | Out-Null }
if ($sessionCwd) { $md.Add("- cwd: $sessionCwd") | Out-Null }
if ($sessionTimestamp) { $md.Add("- started_at: $sessionTimestamp") | Out-Null }
$md.Add("") | Out-Null

$turn = 0
foreach ($m in $messages) {
  if ($m.role -eq "user") {
    $turn++
    $md.Add("## Turn $turn") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("### User") | Out-Null
    $md.Add("") | Out-Null
    $md.Add($m.text) | Out-Null
    $md.Add("") | Out-Null
    continue
  }
  if ($m.role -eq "assistant") {
    if ($turn -eq 0) {
      $turn = 1
      $md.Add("## Turn $turn") | Out-Null
      $md.Add("") | Out-Null
    }
    $md.Add("### Assistant") | Out-Null
    $md.Add("") | Out-Null
    $md.Add($m.text) | Out-Null
    $md.Add("") | Out-Null
  }
}

$utf8WithBom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllLines($outPath, $md.ToArray(), $utf8WithBom)

Write-Output $outPath
