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
    EnableBluetooth = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

  };
  config = lib.mkIf config.EnableBluetooth { hardware.bluetooth.enable = true; };
}
