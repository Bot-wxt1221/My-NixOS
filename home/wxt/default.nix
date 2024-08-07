{
  config,
  pkgs,
  neovim,
  nvchad,
  starter,
  ...
}:

{
  imports = [
    ./gpg.nix
    ./neovim.nix
    ./hyprland
    ./debug-cc.nix
    ./virt.nix
    ./waydroid.nix
    ./archive.nix
    ./java.nix
    ./utils.nix
    ./zsh.nix
    ./git.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
