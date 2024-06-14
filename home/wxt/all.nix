{ config, pkgs, neovim,... }:

{
  imports = [
    ./gpg.nix
    ./debug-cc.nix
    ./virt.nix
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
