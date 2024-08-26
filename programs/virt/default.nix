{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    EnableVirt = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf config.EnableVirt {
    virtualisation.libvirtd.enable = true;
    virtualisation.vswitch.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
  };
}
