{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style = "breeze";
  environment.systemPackages = with pkgs; [
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze
  ];
}
