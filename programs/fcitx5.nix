{
  config,
  lib,
  pkgs,
  nixpkgs,
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
    (self: super: {
      bazel_7 = darwin.apple_sdk_11_0.callPackage ./bazel.nix {
        inherit (darwin) sigtool;
        inherit (darwin.apple_sdk_11_0.frameworks)
          CoreFoundation
          CoreServices
          Foundation
          IOKit
          ;
        buildJdk = jdk21_headless;
        runJdk = jdk21_headless;
        stdenv =
          if stdenv.hostPlatform.isDarwin then
            darwin.apple_sdk_11_0.stdenv
          else if stdenv.cc.isClang then
            llvmPackages.stdenv
          else
            stdenv;
        bazel_self = bazel_7;
      };
    })
  ];
}
