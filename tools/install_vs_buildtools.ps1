$ErrorActionPreference = 'Stop'
.\vs_buildtools.exe `
  --installPath "${PWD}\vs_buildtools" `
  --includeRecommended `
  --add Microsoft.VisualStudio.Workload.VCTools `
  --quiet `
  --wait `
  --norestart
