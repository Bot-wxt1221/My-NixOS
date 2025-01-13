{
  config,
  pkgs,
  neovim,
  nvchad,
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
    ./waydroid.nix
    ./direnv.nix
    ./java.nix
    ./nix.nix
    ./utils.nix
    ./zsh.nix
    ./git.nix
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
  haveBacklight = true;
  nixpkgs.config.allowUnfree = true;
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
}
