{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  options = {
    Laptop = lib.mkEnableOption "laptop";
  };
  config = lib.mkIf config.Laptop {
    services.thermald.enable = true;
    powerManagement.powertop.enable = true;
    environment.systemPackages = [ pkgs.powertop ];
    services.power-profiles-daemon.enable = true;
  };
}
