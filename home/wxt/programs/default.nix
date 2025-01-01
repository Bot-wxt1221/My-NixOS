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
    ./neovim.nix
    ./fcitx5.nix
    ./more.nix
  ];
}
