param($file)
$ErrorActionPreference = 'Stop'
$size = 52428800 # 50 * 1024 * 1024 = 50mb
$in = [System.IO.File]::OpenRead($file)
$buf = New-Object byte[] $size
$part = 1
while ($read = $in.Read($buf, 0, $size)) {
  $out = [System.IO.File]::OpenWrite("${file}.${part}.part")
  $out.Write($buf, 0, $read)
  $out.close()
  $part += 1
}
