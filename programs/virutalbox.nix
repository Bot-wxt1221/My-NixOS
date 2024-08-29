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
    EnableVirtualBox = mkOption {
      type=libs.types.bool;
      default=false;
    };
  };
  config = lib.mkIf config.EnableVirtualBox{
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "wxt" ];
  };
}
