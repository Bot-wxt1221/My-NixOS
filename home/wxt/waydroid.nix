{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.EnableWaydroid {
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
}
