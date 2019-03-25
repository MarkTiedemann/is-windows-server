Write-Host BuildLabEx: (gp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').BuildLabEx
Write-Host InstallationType: (gp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').InstallationType
Write-Host ProductType: (Get-WMIObject Win32_OperatingSystem ProductType).ProductType
Write-Host PSVersion: $PSVersionTable.PSVersion
