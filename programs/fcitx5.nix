{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      libsForQt5.fcitx5-qt
      fcitx5-rime
      fcitx5-gtk
      fcitx5-chinese-addons
    ];
    fcitx5.waylandFrontend = true;
  };
}
