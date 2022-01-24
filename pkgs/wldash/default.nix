{ lib, rustPlatform, fetchFromGitHub
, pkg-config
, dbus, libpulseaudio, alsa-lib, libxkbcommon
, wayland, fontconfig
}:

let
  libraryPath = lib.makeLibraryPath [ wayland libxkbcommon ];
in
rustPlatform.buildRustPackage rec {
  name = "wldash-${version}";
  version = "43fe73bf096111b818e753903e1d5d988ca0c0f1";

  src = fetchFromGitHub {
    owner = "kennylevinsen";
    repo = "wldash";
    rev = "43fe73bf096111b818e753903e1d5d988ca0c0f1";
    sha256 = "1l2b41ayxgh0n6fkzd9pd26wnjw49jw5ip06myv1ylv2vrs4amrs";
  };

  cargoHash = "sha256-iB5eTWkaGyIv5YGCQzPauVRne12YKOmr/RcF0HvFZvQ=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ dbus libpulseaudio alsa-lib fontconfig ];

  dontPatchELF = true;

  postInstall = ''
    patchelf --set-rpath ${libraryPath}:$(patchelf --print-rpath $out/bin/wldash) $out/bin/wldash
  '';

  meta = with lib; {
    description = "Wayland launcher/dashboard";
    homepage = "https://wldash.org";
    licence = licenses.gpl3;
    maintainers = with maintainers; [ alexarice ];
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
