{
  config,
  pkgs,
  neovim,
  niri,
  nvchad,
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
    ./archive.nix
    ./java.nix
    ./utils.nix
    ./nix.nix
    ./zsh.nix
    ./git.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
