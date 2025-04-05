{
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./secret
    ./secret/school-real

    ./shared-modules.nix
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input";
  haveBacklight = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.extraConfig = {
    commit = {
      gpgsign = false;
    };
    user = {
      signingKey = "AE05B887DDD4D65A17FAF9DEFCB35BF8B4724B17";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
