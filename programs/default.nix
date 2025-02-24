{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:
{
  imports = [
    ./kubo.nix
    ./nix/nix.nix
    ./rustdesk.nix
    ./chromium
    #    ./irc.nix
    ./openssh.nix
    ./virutalbox.nix
    ./fuse.nix
    ./steam.nix
    #    ./todesk.nix
    ./miner-gpu.nix
    ./appimage-run.nix
    ./dbus.nix
    ./docker.nix
    ./clash-verge.nix
    ./virt
    ./flatpak.nix
    ./qt.nix
    ./cuda.nix
    ./desktop.nix
    ./fcitx5.nix
    ./waydroid.nix
    ./miner.nix
    ./root-utils.nix
    ./nix-ld.nix
  ];
}
