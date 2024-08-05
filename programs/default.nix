{ config, lib, pkgs, nixpkgs, ... }:
{
  imports = [
    ./kubo.nix
    ./nix/nix.nix
    ./rustdesk.nix
    ./openssh.nix
    ./todesk.nix
    ./miner-gpu.nix
    ./dbus.nix
    ./docker.nix
    ./clash-verge.nix
    ./virt
    ./flatpak.nix
    ./qt.nix
    ./gnome.nix
    ./fcitx5.nix
    ./cc.nix
    ./adb.nix
    ./waydroid.nix
    ./miner.nix
    ./root-utils.nix
    ./nix-ld.nix
    ./cuda.nix
  ];
}
