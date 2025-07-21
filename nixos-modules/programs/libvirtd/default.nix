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
  imports = [
    ./intel-gpu.nix
  ];
  config = lib.mkIf config.EnableVirt {
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;
    virtualisation.vswitch.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
    virtualisation.spiceUSBRedirection.enable = true;
    home-manager.sharedModules = [
      (
        { ... }:
        {
          imports = [

          ];
          dconf.settings = {
            "org/virt-manager/virt-manager/connections" = {
              autoconnect = [ "qemu:///system" ];
              uris = [ "qemu:///system" ];
            };
          };
        }
      )
    ];
  };
}
