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
    ../neovim
    ./fcitx5.nix
    ./more.nix
  ];
}
