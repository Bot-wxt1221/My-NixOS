{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./konsole.nix
    ./qq.nix
    ./neovim
    ./fcitx5.nix
    ./more.nix
    ./nix-index.nix
    ./chromium.nix
    ./waydroid.nix
  ];
}
