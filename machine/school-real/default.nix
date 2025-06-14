{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../nixos-modules
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-school-real";
  Enablesteam = false;
  Enablepipewire = true;
  EnableWaydroid = true;
  EnableVirt = true;
  enableChromium = false;
  enableFirefox = true;

  EnableOllama = true;
  EnableMineGPU = false;
  EnableVirtualBox = false;
  EnableBluetooth = false;
  EnableMineCPU = true;
  EnableCuda = false;
  EnableKubo = false;
  EnableDocker = true;
  Laptop = false;
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
