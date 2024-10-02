# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  nixpkgs,
  pkgs-main,
  hyprland,
  niri,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./network
    ./hardware/g3.nix
    ./security
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-g3";
  Enablepipewire = true;
  EnableWaydroid = true;
  EnableVirt = true;
  EnableMineGPU = false;
  EnableVirtualBox = false;
  EnableBluetooth = true;
  EnableMineCPU = false;
  EnableCuda = true;
  EnableKubo = true;
  EnableDocker = true;
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "libvirtd"
      "video"
      "networkmanager"
    ];
    packages = with pkgs; [ ];
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
#  specialisation = {
#    test-kernel = {
#      configuration = {
#        system.nixos.tags = [ "test-kernel" ];
#        boot.kernelPackages = pkgs.linuxPackagesFor (
#          pkgs.buildLinux {
#            version = "6.12-rc1";
#            extraMeta.branch = "6.12";
#            kernelPatches = [
#              {
#                name = "bridge-stp-helper";
#                patch = "${nixpkgs}/pkgs/os-specific/linux/kernel/bridge-stp-helper.patch";
#              }
#              {
#                name = "request-key-helper";
#                patch = "${nixpkgs}/pkgs/os-specific/linux/kernel/request-key-helper.patch";
#              }
#            ];
#            src = pkgs.fetchzip {
#              url = "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-6.12-rc1.tar.gz";
#              hash = "sha256-olfaNFVQD9qyF/5I0ynv2xa0zxQag/4jyLvZt5nc/Js=";
#            };
#          }
#        );
#      };
#      inheritParentConfig = true;
#    };
#  };
}
