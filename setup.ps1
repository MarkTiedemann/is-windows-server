$ErrorActionPreference = 'Stop'

write-host BuildLabEx: (gp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').BuildLabEx
write-host InstallationType: (gp 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').InstallationType
write-host ProductType: (Get-WMIObject Win32_OperatingSystem ProductType).ProductType
write-host PSVersion: $PSVersionTable.PSVersion

if (!(gcm scoop -ea:SilentlyContinue)) {
  iex (new-object Net.WebClient).DownloadString('https://get.scoop.sh') -ea:SilentlyContinue
}
scoop install make curl touch
