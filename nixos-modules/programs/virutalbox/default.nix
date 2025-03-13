{
  config,
  lib,
  ...
}:
{
  imports = [

  ];
  options = {
    EnableVirtualBox = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.EnableVirtualBox {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "wxt" ];
  };
}
