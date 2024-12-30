{
  config,
  lib,
  niri,
  pkgs,
  ...
}:
{
  imports = [

  ];
  config = {
    services.xserver.enable = true;
    services.displayManager.sessionPackages = [ niri.packages.${pkgs.system}.niri-stable ];
    services.xserver.displaymanager.gdm.enable = true;
  };
}
