Set-PSDebug -Trace 1
msiexec.exe /i python.msi /qn "TARGETDIR=${PWD}\python" ALLUSERS=0
if ($LastExitCode -eq 1603) {
  # https://support.microsoft.com/en-us/help/834484/you-receive-an-error-1603-a-fatal-error-occurred-during-installation
  # Error 1603: Windows Installer is attempting to install an app that is already installed on your PC.
  Write-Warning "Reinstalling python"
  msiexec.exe /x python.msi /qn "TARGETDIR=${PWD}\python" ALLUSERS=0
  msiexec.exe /i python.msi /qn "TARGETDIR=${PWD}\python" ALLUSERS=0
} else {
  $Host.SetShouldExit($LastExitCode)
}
