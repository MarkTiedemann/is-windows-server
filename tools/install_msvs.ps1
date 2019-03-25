$ErrorActionPreference = 'Stop'
.\vs_buildtools.exe `
  --installPath "${PWD}\msvs" `
  --includeRecommended `
  --add Microsoft.VisualStudio.Workload.VCTools `
  --quiet `
  --wait `
  --norestart
