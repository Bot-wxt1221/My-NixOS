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
    EnableWaydroid = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.EnableWaydroid {
    virtualisation.waydroid.enable = true;
    environment.systemPackages = with pkgs; [ waydroid ];
    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/lib/waydroid"
        "/home/wxt/.local/share/waydroid"
      ];
    };
  };
}
