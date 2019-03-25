param($file, $dir)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Expand-Archive $file -Destination $dir
