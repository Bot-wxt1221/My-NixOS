{ config, lib, pkgs, ... }:
{
  imports = [
    ./kubo.nix
    ./nix/nix.nix
    ./openssh.nix
    ./todesk.nix
    ./miner-gpu.nix
    ./dbus.nix
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
    ./miner.nix
    ./root-utils.nix
    ./nix-ld.nix
    ./cuda.nix
  ];
}
