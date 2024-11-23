{
  config,
  pkgs,
  neovim,
  nvchad,
  niri,
  pkgs-main,
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
    ./java.nix
    ./nix.nix
    ./utils.nix
    ./zsh.nix
    ./git.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
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
