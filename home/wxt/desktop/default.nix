{
  config,
  lib,
  pkgs,
  niri,
  pkgs-main,
  ...
}:
{
  imports = [
    ./hyprpaper.nix
    ./niri.nix
    ./waybar.nix
    ./swaync.nix
    ./clipboard.nix
  ];
}
