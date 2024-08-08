# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./network
    ./hardware/g3.nix
    ./security
    ./printing.nix
    ./font.nix
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-g3";
  Enablepipewire = true;
  EnableWaydroid = true;
  EnableMineGPU = false;
  EnableMineCPU = false;
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "libvirtd"
      "video"
    ];
    packages = with pkgs; [ ];
  };
  specialisation = {
    test-kernel = {
      configuration = {
        system.nixos.tags = [ "test-kernel" ];
        boot.kernelPackages = pkgs.linuxPackagesFor (
          pkgs.buildLinux {
            version = "6.11-rc2";
            extraMeta.branch = "6.11";
            kernelPatches = [
              { name = "bridge-stp-helper";
                patch = ${nixpkgs}/pkgs/os-specific/linux/kernel/bridge-stp-helper.patch;
              }
              { name = "request-key-helper-updated";
                patch = ${nixpkgs}/pkgs/os-specific/linux/kernel/request-key-helper-updated.patch;
              }
            ];
            src = lib.fetchzip {
              url = "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-6.11-rc2.tar.gz";
            };
          }
        );
      };
      inheritParentConfig = true; 
    };
  };
}
