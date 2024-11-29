{
  stdenvNoCC,
  lib,
}:

stdenvNoCC.mkDerivation rec {
  pname = "STSong";
  version = "1.0.0";

  src = ./STSong.TTF;

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    install -Dm644 ${src} $out/share/fonts/truetype/STSong.ttf
  '';
}
