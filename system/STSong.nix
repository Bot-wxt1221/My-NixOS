{
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation rec {
  pname = "STSong";
  version = "1.0.0";

  src = ./STSong.TTF;

  doUnpack = false;
  doBuild = false;

  installPhase = ''
    install -Dm644 ${src} $out/share/fonts/truetype/STSong.ttf
  '';
}
