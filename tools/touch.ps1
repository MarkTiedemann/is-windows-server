param($item)
$ErrorActionPreference = 'Stop'
(Get-ChildItem $item).LastWriteTime = Get-Date
