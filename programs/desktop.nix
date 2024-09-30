{
  config,
  lib,
  pkgs,
  pkgs-main,
  hyprland,
  ...
}:
{
  imports = [

  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    dconf
    gnome-terminal
    gnome-tweaks
    gnome-system-monitor
  ];
  programs.niri.enable = true;
  programs.niri.config = null;
  programs.dconf.enable = true;
  programs.light.enable = true;
  services.power-profiles-daemon.enable = true;
  programs.gnome-disks.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
