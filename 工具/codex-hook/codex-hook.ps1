param(
  [string]$LogDir,
  [switch]$NoLog,
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Args
)

$ErrorActionPreference = "Stop"

if (-not $LogDir) {
  if ($env:CODEX_LOG_DIR) {
    $LogDir = $env:CODEX_LOG_DIR
  } else {
    $vaultRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
    $LogDir = Join-Path $vaultRoot "待整理\\AI对话"
  }
}

function Get-RealCodexPath() {
  if ($env:CODEX_REAL -and (Test-Path $env:CODEX_REAL)) { return $env:CODEX_REAL }
  $all = Get-Command codex -All -ErrorAction SilentlyContinue
  foreach ($c in $all) {
    if ($c.CommandType -eq "ExternalScript" -or $c.CommandType -eq "Application") {
      if ($c.Source -and (Test-Path $c.Source)) { return $c.Source }
      if ($c.Path -and (Test-Path $c.Path)) { return $c.Path }
    }
  }
  throw "Cannot locate the real 'codex' executable/script."
}

if ($Args -contains "--no-log") {
  $NoLog = $true
  $Args = $Args | Where-Object { $_ -ne "--no-log" }
}

$start = Get-Date
$real = Get-RealCodexPath
$tailJob = $null

if (-not $NoLog) {
  $tailer = Join-Path $PSScriptRoot "tail-codex-session.ps1"
  $cwd = (Get-Location).Path
  $tailJob = Start-Job -ScriptBlock {
    param($tailerPath, $startTime, $cwdPath, $logDirPath)
    & $tailerPath -StartTime $startTime -Cwd $cwdPath -LogDir $logDirPath | Out-Null
  } -ArgumentList @($tailer, $start, $cwd, $LogDir)
}

& $real @Args
$exitCode = $LASTEXITCODE

if ($tailJob) {
  Start-Sleep -Milliseconds 800
  try { Stop-Job -Job $tailJob -Force -ErrorAction SilentlyContinue } catch {}
  try { Remove-Job -Job $tailJob -Force -ErrorAction SilentlyContinue } catch {}
}

exit $exitCode
