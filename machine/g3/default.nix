# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../nixos-modules
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-g3";
  Enablesteam = true;
  Enablepipewire = true;
  EnableWaydroid = true;
  EnableVirt = true;
  enableChromium = false;
  enableFirefox = true;

  EnableOllama = true;
  EnableMineGPU = false;
  EnableVirtualBox = false;
  EnableBluetooth = true;
  EnableMineCPU = false;
  EnableCuda = true;
  EnableKubo = false;
  EnableDocker = true;
  Laptop = true;
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
