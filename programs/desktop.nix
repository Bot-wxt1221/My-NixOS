{
  config,
  lib,
  pkgs,
  pkgs-main,
  hyprland,
  niri,
  ...
}:
{
  imports = [

  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = [ niri.packages.niri ];
  environment.systemPackages = with pkgs; [
    dconf
    gnome-terminal
    gnome-tweaks
    gnome-system-monitor
  ];
  programs.dconf.enable = true;
  programs.light.enable = true;
  services.power-profiles-daemon.enable = true;
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  programs.gnome-disks.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
