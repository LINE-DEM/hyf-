param(
  [string]$HookPath,
  [string]$LogDir,
  [switch]$AlsoInstallForWindowsPowerShell
)

$ErrorActionPreference = "Stop"

if (-not $HookPath) {
  $HookPath = Join-Path $PSScriptRoot "codex-hook.ps1"
}

if (-not $LogDir) {
  $vaultRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
  $LogDir = Join-Path $vaultRoot "待整理\\AI对话"
}

if (-not (Test-Path $HookPath)) {
  throw "HookPath not found: $HookPath"
}

function Get-RealCodexPathNow() {
  $all = Get-Command codex -All -ErrorAction SilentlyContinue
  foreach ($c in $all) {
    if ($c.CommandType -eq "ExternalScript" -or $c.CommandType -eq "Application") {
      if ($c.Source -and (Test-Path $c.Source)) { return $c.Source }
      if ($c.Path -and (Test-Path $c.Path)) { return $c.Path }
    }
  }
  throw "Cannot locate current real 'codex' executable/script."
}

$realCodex = Get-RealCodexPathNow

$block = @"

# >>> codex-hook start >>>
`$env:CODEX_LOG_DIR = '$LogDir'
`$env:CODEX_REAL = '$realCodex'
function codex { & '$HookPath' -LogDir `$env:CODEX_LOG_DIR @args }
function codex_raw { & `$env:CODEX_REAL @args }
# <<< codex-hook end <<<

"@

function Upsert-ProfileBlock([string]$ProfilePath) {
  $startMarker = "# >>> codex-hook start >>>"
  $endMarker = "# <<< codex-hook end <<<"

  if (-not (Test-Path $ProfilePath)) {
    New-Item -ItemType File -Force -Path $ProfilePath | Out-Null
  }

  $content = Get-Content -Encoding UTF8 -Raw -Path $ProfilePath -ErrorAction SilentlyContinue
  if ($null -eq $content) { $content = "" }

  $pattern = [regex]::Escape($startMarker) + "[\\s\\S]*?" + [regex]::Escape($endMarker)
  $newContent = $content
  while ([regex]::IsMatch($newContent, $pattern)) {
    $newContent = [regex]::Replace($newContent, $pattern, "")
  }
  $newContent = $newContent.TrimEnd() + $block

  $utf8Bom = New-Object System.Text.UTF8Encoding($true)
  [System.IO.File]::WriteAllText($ProfilePath, $newContent, $utf8Bom)
}

$targets = @()
$targets += $PROFILE.CurrentUserAllHosts
if ($AlsoInstallForWindowsPowerShell) {
  $winProfile = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "WindowsPowerShell\\Microsoft.PowerShell_profile.ps1"
  $targets += $winProfile
}

$targets = $targets | Select-Object -Unique
foreach ($p in $targets) {
  Upsert-ProfileBlock -ProfilePath $p
  Write-Output "Installed in: $p"
}
