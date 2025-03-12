{
  config,
  pkgs,
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/bazhong

    ./shared-modules.nix
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
  haveBacklight = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.signing.format = lib.mkForce "openpgp";
}
