{
  config,
  lib,
  pkgs,
  niri,
  ...
}:
{
  imports = [
    ./hyprpaper.nix
    ./waybar.nix
    ./niri.nix
    ./swaync.nix
    #    ./clipboard.nix
  ];
}
