{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
  ];
  home.persistence."/persist/home/wxt" = {
    directories = [
      ".config/QQ"
    ];
  };
  home.packages = with pkgs; [
    (qq.overrideAttrs (old: {
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
