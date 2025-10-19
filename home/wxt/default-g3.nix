{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/g3
    ./utils.nix

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
      signingKey = "BDAC82F1F8362EB5956CB53EBA67F009299A3A3E";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
