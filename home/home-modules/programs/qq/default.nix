{
  pkgs,
  ...
}:
{
  imports = [
  ];
  home.packages = with pkgs; [
    (qq.overrideAttrs (old: {
      src = src.overrideAttrs (old2: {
        preferLocalBuild = true;

      });
      preferLocalBuild = true;
      installPhase =
        old.installPhase
        + ''
          wrapProgram $out/bin/qq \
            --unset NIXOS_OZONE_WL
        '';
    }))
  ];
}
