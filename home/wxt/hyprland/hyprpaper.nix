{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.file.".config/hypr/wallpaper.jpeg".source = ./wallpaper.jpeg;
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "${config.home.homeDirectory}/.config/hypr/wallpaper.jpeg" ];
    wallpaper = [ ",${config.home.homeDirectory}/.config/hypr/wallpaper.jpeg" ];
  };
  home.packages = with pkgs; [ hyprpaper ];
}
