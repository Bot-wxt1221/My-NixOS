{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    swaylock-effects
  ];
  home.file = {
    ".config/sway-lock/config" = {
      source = ./swaylock-config;
    };
  };
}
