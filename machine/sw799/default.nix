# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../nixos-modules
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-sw799";
  Enablesteam = false;
  Enablepipewire = true;
  EnableWaydroid = false;
  EnableVirt = false;
  enableChromium = false;
  enableFirefox = false;

  EnableOllama = false;
  EnableMineGPU = false;
  EnableVirtualBox = false;
  EnableBluetooth = true;
  EnableMineCPU = false;
  EnableCuda = false;
  EnableKubo = false;
  EnableDocker = true;
  Laptop = false;
  preservation.enable = lib.mkForce false;
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
    hashedPasswordFile = config.sops.secrets.wxt-password.path;
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
