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
    (self: super: rec {
      bazel_7 = pkgs.darwin.apple_sdk_11_0.callPackage ./bazel.nix {
        inherit (pkgs.darwin) sigtool;
        inherit (pkgs.darwin.apple_sdk_11_0.frameworks)
          CoreFoundation
          CoreServices
          Foundation
          IOKit
          ;
        buildJdk = pkgs.jdk21_headless;
        runJdk = pkgs.jdk21_headless;
        stdenv =
          if pkgs.stdenv.hostPlatform.isDarwin then
            pkgs.darwin.apple_sdk_11_0.stdenv
          else if pkgs.stdenv.cc.isClang then
            pkgs.llvmPackages.stdenv
          else
            pkgs.stdenv;
        bazel_self = bazel_7;
      };
    })
  ];
}
