# Verifies the Windows side of the GeoResilience setup. Read-only: installs nothing.
# Usage (PowerShell):  powershell -ExecutionPolicy Bypass -File scripts\check_env.ps1

$missing = 0
function Ok($n, $m)   { Write-Host ("  OK       {0,-18} {1}" -f $n, $m) -ForegroundColor Green }
function Miss($n, $m) { Write-Host ("  MISSING  {0,-18} {1}" -f $n, $m) -ForegroundColor Red; $script:missing++ }
function Warn($n, $m) { Write-Host ("  WARN     {0,-18} {1}" -f $n, $m) -ForegroundColor Yellow }
function Has($cmd)    { $null -ne (Get-Command $cmd -ErrorAction SilentlyContinue) }

Write-Host "== WSL"
if (Has "wsl") {
  $distros = (wsl.exe -l -q 2>$null) -replace "`0", "" | Where-Object { $_ -match '\S' }
  if ($distros -match 'Ubuntu') { Ok "WSL + Ubuntu" (($distros -match 'Ubuntu') -join ', ') }
  else { Miss "Ubuntu (WSL)" "Run as admin: wsl --install -d Ubuntu-24.04" }
} else { Miss "WSL" "Run as admin: wsl --install -d Ubuntu-24.04" }

Write-Host "== Windows tools"
if (Has "git")  { Ok "git" ((git --version) -replace 'git version ','') } else { Miss "git" "winget install --id Git.Git -e" }
if (Has "gh")   { Ok "GitHub CLI" (((gh --version) | Select-Object -First 1)) } else { Warn "GitHub CLI" "optional on Windows (used inside WSL): winget install --id GitHub.cli -e" }
if (Has "code") { Ok "VS Code" (((code --version) | Select-Object -First 1)) } else { Miss "VS Code" "winget install --id Microsoft.VisualStudioCode -e" }
if (Test-Path "C:\Program Files\QGIS*") { Ok "QGIS" "installed" } else { Warn "QGIS" "needed for reference checks (Week 7): winget install --id OSGeo.QGIS_LTR -e" }

if (Has "code") {
  $ext = code --list-extensions
  foreach ($e in @("ms-vscode-remote.remote-wsl","ms-vscode.cpptools","ms-vscode.cmake-tools","ms-python.python","anthropic.claude-code")) {
    if ($ext -contains $e) { Ok "ext" $e } else { Warn "ext" "$e  (code --install-extension $e)" }
  }
}

Write-Host "== Cost and conflict checks"
if ($env:ANTHROPIC_API_KEY) { Warn "ANTHROPIC_API_KEY" "SET on Windows: Claude Code will bill this key instead of your subscription." }
else { Ok "ANTHROPIC_API_KEY" "not set" }
$userKey = [Environment]::GetEnvironmentVariable("ANTHROPIC_API_KEY","User")
if ($userKey) { Warn "ANTHROPIC_API_KEY" "set as a persistent User variable; remove it in System > Environment Variables unless intended." }
if (($env:Path -split ';') -match 'anaconda3|miniconda') { Warn "Anaconda on PATH" "fine for Python, but keep C++ builds in WSL to avoid GDAL/PROJ conflicts." }

$vbox = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
if (Test-Path $vbox) {
  $v = & $vbox --version
  if ([version]($v -replace '[^0-9.].*$','') -lt [version]"6.1") { Warn "VirtualBox" "$v is old; update it so it coexists with WSL2/Hyper-V." }
  else { Ok "VirtualBox" "$v (compatible with WSL2)" }
}

if (Test-Path "C:\georesilience\.git") { Ok "repo" "C:\georesilience is a git repo" }
elseif (Test-Path "C:\georesilience") { Warn "repo" "C:\georesilience exists but is not a git repo yet (see README: push to GitHub)" }

Write-Host ""
if ($missing -eq 0) { Write-Host "Windows side looks good. Next: open Ubuntu and run ./scripts/check_env.sh" }
else { Write-Host "$missing required item(s) missing."; exit 1 }
