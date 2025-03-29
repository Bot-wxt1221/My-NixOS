{
  nur,
  ...
}:
{
  imports = [
    nur.modules.nixos.default
    ./appimage-run
    ./chromium
    ./clash-verge
    ./dbus
    ./desktop
    ./docker
    ./ejabberd
    ./fcitx5
    ./flatpak
    ./fuse
    ./irc-server
    ./kubo
    ./libvirtd
    ./miner-cpu
    ./miner-gpu
    ./nix
    ./nix-ld
    ./ollama
    ./openssh
    ./qt
    # ./rustdesk
    ./steam
    ./virutalbox
    ./waydroid

    ./root-utils.nix
  ];
}
