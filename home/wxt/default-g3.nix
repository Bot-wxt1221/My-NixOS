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
      signingKey = "394F3D16BB4C7ED9652A97F7CD52BEC2EFE360C8";
    };
  };
}
