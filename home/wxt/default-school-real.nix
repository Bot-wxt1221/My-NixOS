{
  config,
  pkgs,
  osConfig,
  lib,
  ...
}:

{
  imports = [
    ./gpg.nix
    ./direnv.nix
    ./desktop
    ./programs
    ./debug-cc.nix
    ./persist.nix
    ./virt.nix
    ./waydroid.nix
    ./java.nix
    ./utils.nix
    ./nix.nix
    ./zsh.nix
    ./git.nix
    ./secret
    ./secret/school-real
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
      signingKey = "AE05B887DDD4D65A17FAF9DEFCB35BF8B4724B17";
    };
  };
  programs.git.signing.format = lib.mkForce "openpgp";
}
