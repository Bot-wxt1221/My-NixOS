{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./desktop
    ./java
    ./konsole
    ./neovim
    ./nix-index
    ./qq
  ];
}
