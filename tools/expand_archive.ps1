param($1)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Expand-Archive $1
