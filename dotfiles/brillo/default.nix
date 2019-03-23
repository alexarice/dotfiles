{stdenv, fetchurl, which, go-md2man}:

let
  v = "1.4.3";
in
stdenv.mkDerivation {
  version = v;
  name = "brillo-${v}";
  src = fetchurl {
  url = "https://gitlab.com/cameronnemo/brillo/-/archive/v${v}/brillo-v${v}.tar.bz2";
    sha256 = "0wjpw9vn521rwpnlhvczzfzdsdq812vsyl151627qw51zadynvz1";
  };
  patches = [./brillo.patch];
  makeFlags = [ "PREFIX=$(out)" ];
  nativeBuildInputs = [go-md2man which];
  buildFlags = [ "dist" ];
  installTargets = "install-dist";

  meta = with stdenv.lib; {
    description = "Backlight and Keyboard LED control tool";
    homepage = https://gitlab.com/cameronnemo/brillo;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.alexarice ];
  };
}
