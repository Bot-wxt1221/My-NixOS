{
  pkgs,
  osConfig,
  lib,
  ...
}:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = osConfig.i18n.inputMethod.fcitx5.addons;
    fcitx5.waylandFrontend = true;
    fcitx5.fcitx5-with-addons = pkgs.kdePackages.fcitx5-with-addons;
  };
  systemd.user.services.fcitx5-daemon = lib.mkForce { };
}
