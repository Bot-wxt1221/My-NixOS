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
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  programs.git.extraConfig = {
    commit = {
      gpgsign = true;
    };
    user = {
      signingKey = "E834B5093C621EFE92D7CC1AF41E2366C0EDC8BC";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
