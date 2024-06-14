{ config, lib, pkgs, ... }:
{
  imports = [
    ./kubo.nix
    ./nix/nix.nix
    ./todesk.nix
    ./docker.nix
    ./clash-verge.nix
    ./virt/all.nix
    ./flatpak.nix
    ./qt.nix
    ./gnome.nix
    ./fcitx5.nix
    ./cc.nix
    ./adb.nix
    ./waydroid.nix
    ./root-utils.nix
  ];
}
