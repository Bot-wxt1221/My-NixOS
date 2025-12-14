{
  pkgs,
  osConfig,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.enableDesktop {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = osConfig.i18n.inputMethod.fcitx5.addons;
      fcitx5.waylandFrontend = true;
      fcitx5.fcitx5-with-addons = pkgs.kdePackages.fcitx5-with-addons;
    };
    systemd.user.services.fcitx5-daemon = lib.mkForce { };
  };
}
