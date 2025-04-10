{
  pkgs,
  lib,
  ...
}:
let
  niri-use = pkgs.niri.overrideAttrs (
    new: old: {
      src = pkgs.fetchFromGitHub {
        owner = "YaLTeR";
        repo = "niri";
        rev = "53d1efd3bc3d45f4a97ad2d0ad6f5768c7e557a3";
        hash = "sha256-jR2GreUW+FkoUiBPZ/+PsApi+RseTWU+4F41MXv12X0=";
      };
      cargoDeps = old.cargoDeps.overrideAttrs (oldAttrs': {
        vendorStaging = oldAttrs'.vendorStaging.overrideAttrs {
          inherit (new) src;
          outputHash = "sha256-5wK8cPEIw5VIsghikWlnuyaOp/qaG5ZCCwoiFEumyoE=";
        };
      });
    }
  );
in
{
  imports = [

  ];
  options = {
    niriInUse = lib.mkOption {
      type = lib.types.package;
      default = niri-use;
    };
  };
  config = {
    security.pam.services.swaylock = { };
    security.pam.services.wayvnc = {
      text = ''
        auth    required pam_unix.so nodelay deny=3 unlock_time=600
        account required pam_unix.so nodelay deny=3 unlock_time=600
      '';
    };
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    services.displayManager.sessionPackages = [ niri-use ];
    environment.systemPackages = with pkgs; [
      dconf
      niri-use
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
    systemd.user.services.niri-flake-polkit.enable = true;
    programs.dconf.enable = true;
    programs.light.enable = true;
    xdg.portal.enable = true;
    xdg.portal.config.common.default = "*";
    programs.gnome-disks.enable = true;
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
