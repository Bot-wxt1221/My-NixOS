{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware/school-vmware.nix
    ./network
    ./security
    ./persist.nix
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-school-vmware";
  Enablepulseaudio = true;
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "video"
      "networkmanager"
    ];
    hashedPassword = "$y$j9T$XjbKBaxc32Pc.Mj4HQ.tu/$mxn7xvy5I/1/bv/eF64cwMSakLuFM1YgjU44r249I7/";
    packages = with pkgs; [ ];
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
