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
  programs.git.settings = {
    commit = {
      gpgsign = false;
    };
    user = {
      signingKey = "CA84C7AEB96B2788DADCA9FD039BE163733B8242";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
