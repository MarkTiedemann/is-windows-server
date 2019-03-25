$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

<#
.\vs_buildtools.exe `
  --installPath "${PWD}\msvs" `
  --includeRecommended `
  --add Microsoft.VisualStudio.Workload.VCTools `
  --quiet `
  --wait `
  --norestart
#>

# Compress-Archive msvs\msbuild -Destination msbuild.zip

mkdir.exe msvs
