{stdenv, fetchurl, which, go-md2man}:

stdenv.mkDerivation rec {
  version = "1.4.3";
  name = "brillo-${version}";
  src = fetchurl {
    url = "https://gitlab.com/cameronnemo/brillo/-/archive/v1.4.3/brillo-v1.4.3.tar.bz2";
    sha256 = "0wjpw9vn521rwpnlhvczzfzdsdq812vsyl151627qw51zadynvz1";
  };
  patches = [./brillo.patch];
  makeFlags = [ "PREFIX=$(out)" ];
  nativeBuildInputs = [go-md2man which];
  dontBuild = true;
  installTargets = "dist install-dist";
}
