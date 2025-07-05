{
  pkgs,
  ...
}:
{
  imports = [
  ];
  home.packages = with pkgs; [
    (symlinkJoin {
      name = "QQ";
      paths = [ qq ];
      inherit (qq) meta;
      buildInputs = [
        makeWrapper
      ];
      postBuild = ''
        rm $out/share/applications/qq.desktop
        cp ${qq}/share/applications/qq.desktop $out/share/applications/qq.desktop
        substituteInPlace $out/share/applications/qq.desktop \
          --replace-fail "${qq}" $out
        wrapProgram $out/bin/qq \
          --add-flags '--wayland-text-input-version=3'
      '';
    })
  ];
}
