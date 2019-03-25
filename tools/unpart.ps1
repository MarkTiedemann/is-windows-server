param($file)
$ErrorActionPreference = 'Stop'
$out = [System.Io.File]::OpenWrite($file)
$part = 1
$in = "${file}.${part}.part"
while (Test-Path $in) {
    $buf = [System.IO.File]::ReadAllBytes($in)
    $out.Write($buf, 0, $buf.Count)
    $part += 1
    $in = "${file}.${part}.part"
}
$out.close()
