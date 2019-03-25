param($dir, $file)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Compress-Archive $dir -Destination $file
