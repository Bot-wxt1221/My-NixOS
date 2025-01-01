{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./konsole.nix
    ./fcitx5.nix
  ];
}
