{
  config,
  lib,
  pkgs,
  hyprland,
  niri,
  ...
}:
{
  imports = [

  ];
  config = lib.mkMerge [
    ({
      environment.systemPackages = with pkgs; [
        dconf
        niri.packages.${pkgs.system}.niri-stable
        gnome-tweaks
        gnome-system-monitor
      ];
      programs.xwayland = {
        enable = true;
        package = pkgs.xwayland-satellite;
      };
      environment.sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        QT_IM_MODULE = "fcitx5";
        GTK_IM_MODULE = "fcitx5";
        NIXOS_OZONE_WL = 1;
      };
      systemd.user.services.niri-flake-polkit.enable = false;
      programs.dconf.enable = true;
      programs.light.enable = true;
      xdg.portal.enable = true;
      xdg.portal.config.common.default = "*";
      programs.gnome-disks.enable = true;
      services.devmon.enable = true;
      services.gvfs.enable = true;
      services.gnome.gnome-keyring.enable = true;
    })
  ];
}
