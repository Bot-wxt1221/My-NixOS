{
  element-desktop,
  stdenv,
  lib,
  makeShellWrapper,
}:

stdenv.mkDerivarion (finalAttrs: {
  pname = "element-desktop-wrap";

  nativeBuildInputs = [ makeShellWrapper ];

  buildPhase = ''
    cp -r ${element-desktop}/* $out
    wrapProgramShell "$out/bin/element-desktop" --add-flags "--ozone-platform-hint=wayland --enable-wayland-ime";
  '';
})
