Write-Host BuildLabEx: (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').BuildLabEx
Write-Host InstallationType: (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').InstallationType
Write-Host ProductType: (Get-WMIObject Win32_OperatingSystem ProductType).ProductType
