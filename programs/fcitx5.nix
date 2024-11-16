{
  config,
  lib,
  pkgs,
  nixpkgs,
  pkgs-bazel,
  ...
}:
{
  imports = [

  ];
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      libsForQt5.fcitx5-qt
      fcitx5-with-addons
      fcitx5-gtk
      fcitx5-rime
      fcitx5-chinese-addons
    ];
    fcitx5.waylandFrontend = true;
  };
  nixpkgs.overlays = [
    (self: super: rec {
      bazel_7 = pkgs-bazel.bazel_7;
      fcitx5-mozc = pkgs.fcitx5-mozc.override{
        bazel_7 = pkgs-bazel.bazel_7;
      };
    })
  ];
}
