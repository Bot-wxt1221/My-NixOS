{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.file.".config/hypr/wallpaper.png".source = ./nixos-wallpaper-catppuccin-latte.png;
  home.file.".config/hypr/hyprpaper.conf".text = ''
    perload = ${config.home.homeDirectory}/.config/hypr/wallpaper.png
    wallpaper = ,${config.home.homeDirectory}/.config/hypr/wallpaper.png
  '';
  services.hyprpaper.enable = true;
}
