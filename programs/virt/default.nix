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
      default = false;
    };
  };
  config = lib.mkIf config.EnableVirt {
    virtualisation.libvirtd.enable = true;
    virtualisation.vswitch.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.kvmgt.enable = true;
    virtualisation.kvmgt.vgpus = {
      "i915-GVTg_V5_4" = {
        uuid = [ "a9e82ce4-e116-11ef-a82e-23078161a38b" ];
      };
    };
  };
}
