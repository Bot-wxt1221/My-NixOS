{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.packages = with pkgs; [
    swaylock-effects
  ];
  home.file = {
    ".config/sway-lock/config" = {
      source = ./swaylock-config;
    };
  };
}
