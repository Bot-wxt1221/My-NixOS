{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/g3

    ./shared-modules.nix
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
  haveBacklight = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.extraConfig = {
    commit = {
      gpgsign = true;
    };
    user = {
      signingKey = "D2F78642E924DCACF864327B67E8436D09A65130";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
