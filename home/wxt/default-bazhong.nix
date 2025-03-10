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
    ./desktop
    ./persist.nix
    ./debug-cc.nix
    ./virt.nix
    ./programs
    ./direnv.nix
    ./java.nix
    ./nix.nix
    ./utils.nix
    ./zsh.nix
    ./git.nix
    ./secret
    ./secret/bazhong
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
  haveBacklight = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
  programs.git.signing.format = lib.mkForce "openpgp";
}
