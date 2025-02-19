{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ./hardware/mininal-config.nix
    ./network
    ./persist.nix
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-mininal-config";
  Enablepipewire = true;
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    hashedPassword = "$y$j9T$XjbKBaxc32Pc.Mj4HQ.tu/$mxn7xvy5I/1/bv/eF64cwMSakLuFM1YgjU44r249I7/";
    packages = with pkgs; [ ];
  };
}
