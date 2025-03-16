{
  config,
  lib,
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
  config = lib.mkIf config.EnableBluetooth {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    preservation.preserveAt."/persist" = {

      directories = [
        "/var/lib/bluetooth"
        "/etc/bluetooth"
      ];
    };
  };
}
