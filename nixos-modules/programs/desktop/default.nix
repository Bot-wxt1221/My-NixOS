{
  pkgs,
  lib,
  niri-flake,
  ...
}:
let
  niri-use = niri-flake.packages.${pkgs.system}.niri-unstable.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      pushd $cargoDepsCopy/smithay-0.7.0
        patch -p1 < ${./0550cb9c2c18c18f91bda00ac8fb23300e799805.patch}
      popd
    '';
  });
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
    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.wayland = true;
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
