# Read-only: shows how much disk space GeoResilience and its tools use. Deletes nothing.
# Usage:  powershell -ExecutionPolicy Bypass -File C:\georesilience\scripts\space_report.ps1

function SizeGB($path) {
  if (-not (Test-Path $path)) { return $null }
  $bytes = (Get-ChildItem -LiteralPath $path -Recurse -Force -File -ErrorAction SilentlyContinue |
            Measure-Object -Property Length -Sum).Sum
  return [math]::Round(($bytes / 1GB), 2)
}
function Row($name, $gb, $note) {
  $val = if ($null -eq $gb) { "not found" } else { "$gb GB" }
  Write-Host ("  {0,-32} {1,12}   {2}" -f $name, $val, $note)
}

$root = "C:\georesilience"
Write-Host "== Project folder ($root)"
Row "build/"          (SizeGB "$root\build")       "safe to delete (rebuildable)"
Row "data/raw/"       (SizeGB "$root\data\raw")    "safe to delete (re-downloadable)"
Row "data/interim/"   (SizeGB "$root\data\interim") "safe to delete"
Row ".venv/"          (SizeGB "$root\.venv")       "safe to delete (pip reinstall)"
Row "whole folder"    (SizeGB $root)               ""

Write-Host "== WSL virtual disks (Ubuntu and everything installed inside it)"
$candidates = @()
$candidates += Get-ChildItem "$env:LOCALAPPDATA\Packages\CanonicalGroupLimited*\LocalState\ext4.vhdx" -ErrorAction SilentlyContinue
$candidates += Get-ChildItem "$env:LOCALAPPDATA\wsl\*\ext4.vhdx" -ErrorAction SilentlyContinue
if ($candidates.Count -eq 0) { Row "ext4.vhdx" $null "WSL not installed yet, or stored elsewhere" }
foreach ($v in $candidates) {
  Row "ext4.vhdx" ([math]::Round($v.Length / 1GB, 2)) $v.FullName
}

Write-Host "== Windows apps"
$qgis = Get-ChildItem "C:\Program Files" -Directory -Filter "QGIS*" -ErrorAction SilentlyContinue | Select-Object -First 1
Row "QGIS" $(if ($qgis) { SizeGB $qgis.FullName } else { $null }) ""
Row "VS Code extensions" (SizeGB "$env:USERPROFILE\.vscode\extensions") "shared with other projects"

Write-Host "== Drive C:"
$d = Get-PSDrive C
Write-Host ("  Free: {0} GB   Used: {1} GB" -f [math]::Round($d.Free/1GB,1), [math]::Round($d.Used/1GB,1))
Write-Host ""
Write-Host "To reclaim space, see docs\teardown.md"
