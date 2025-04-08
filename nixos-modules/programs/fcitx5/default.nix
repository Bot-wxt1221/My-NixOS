{
  pkgs,
  ...
}:
{
  imports = [

  ];
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      libsForQt5.fcitx5-qt
      kdePackages.fcitx5-qt
      (kdePackages.fcitx5-with-addons.overrideAttrs (old: {
        postBuild =
          old.postInstall or ""
          + ''
            rm $out/$autostart
          '';
      }))
      fcitx5-gtk
      fcitx5-rime
      fcitx5-chinese-addons
    ];
    fcitx5.waylandFrontend = true;
    fcitx5.plasma6Support = true;
  };
  home-manager.sharedModules = [
    (
      {
        ...
      }:
      {
        imports = [

        ];
        home.file.".config/fcitx5" = {
          source = ./fcitx5-config;
        };
      }
    )
  ];
}
