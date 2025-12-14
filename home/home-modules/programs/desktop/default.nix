{
  lib,
  ...
}:
{
  options = {
    enableDesktop = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  imports = [
    ./fcitx5.nix
    ./hyprpaper.nix
    ./waybar
    ./niri.nix
    ./swaync
    #    ./clipboard.nix
  ];
}
