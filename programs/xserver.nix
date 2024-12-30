{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  config = lib.mkIf config.enableDisplayManager {
    services.xserver.enable = true;
    services.displayManager.sessionPackages = [ niri.packages.${pkgs.system}.niri-stable ];
    services.xserver.displaymanager.gdm.enable = true;
  };
}
