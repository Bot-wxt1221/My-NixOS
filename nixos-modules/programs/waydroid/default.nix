{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  options = {
    EnableWaydroid = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.EnableWaydroid {
    virtualisation.waydroid.enable = true;
    environment.systemPackages = with pkgs; [ waydroid ];
    preservation.preserveAt."/persist" = {
      directories = [
        "/var/lib/waydroid"
        "/home/wxt/.local/share/waydroid"
      ];
    };
    home-manager.sharedModules = [
      (_: {
        config = {
          home.file.".local/share/applications/Waydroid-Full-Ui.desktop".text = ''
            [Desktop Entry]
            Type=Application
            Name=Waydroid-Full-Ui
            Comment=Waydroid Full Ui
            Exec=waydroid show-full-ui
            Icon=waydroid
            Terminal=false
            Categories=X-WayDroid-App;
            X-Purism-FormFactor=Workstation;Mobile;
          '';
        };
      })
    ];
  };
}
