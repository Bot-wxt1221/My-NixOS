{
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation rec {
  pname = "STSong";
  version = "1.0.0";

  src = ./STSong.TTF;

  installPhase = ''
    install -Dm644 ${src} $out/share/fonts/truetype/STSong.ttf
  '';
}
