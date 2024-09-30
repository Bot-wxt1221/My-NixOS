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
  services.displayManager.sessionPackages = [ niri.packages.${pkgs.system}.niri-stable ];
  environment.systemPackages = with pkgs; [
    dconf
    niri.packages.${pkgs.system}.niri-stable
    gnome-terminal
    gnome-tweaks
    gnome-system-monitor
  ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
    QT_IM_MODULE = "fcitx5";
    GTK_IM_MODULE = "fcitx5";
  };
  systemd.user.services.niri-flake-polkit.enable = false;
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
