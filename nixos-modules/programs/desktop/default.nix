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
        rev = "7345961a46c90fd82b51effa4e122c5ea3d3ba00";
        hash = "sha256-zp/R45oGSbvzV53nPE3EM8aGtn1DvvWHRDD4WxhzuMU=";
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
