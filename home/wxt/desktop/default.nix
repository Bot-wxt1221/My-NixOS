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
    ./hyprland.nix
    ./waybar.nix
    ./swaync.nix
    ./clipboard.nix
  ];
}
