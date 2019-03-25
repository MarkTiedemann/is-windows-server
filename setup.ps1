$ErrorActionPreference = 'Stop'
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop bucket add versions
scoop install make curl touch 7zip python27
