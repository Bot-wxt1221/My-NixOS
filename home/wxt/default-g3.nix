{
  config,
  pkgs,
  neovim,
  nvchad,
  niri,
  ...
}:

{
  imports = [
    ./gpg.nix
    ./neovim.nix
    ./desktop
    ./debug-cc.nix
    ./virt.nix
    ./waydroid.nix
    ./direnv.nix
    ./java.nix
    ./nix.nix
    ./utils.nix
    ./zsh.nix
    ./git.nix
  ];
  cpuTempDevice = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
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
      signingKey = "7D01C38E6B886424C0A51B348281D5EE2D1825A4";
    };
  };
}
