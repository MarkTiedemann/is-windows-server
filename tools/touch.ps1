param($item)
$ErrorActionPreference = 'Stop'
if (Test-Path -Type Container $item) {
  $info = New-Object System.IO.DirectoryInfo($item)
}
else {
  $info = New-Object System.IO.FileInfo($item)
}
$info.LastWriteTime = Get-Date
