{
  element-desktop,
  stdenv,
  lib,
  makeShellWrapper,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "element-desktop-wrap";
  version = "0.0.0";

  nativeBuildInputs = [ makeShellWrapper ];

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp -r ${element-desktop}/* $out
    wrapProgramShell "$out/bin/element-desktop" --add-flags "--ozone-platform-hint=wayland --enable-wayland-ime";
  '';
})
