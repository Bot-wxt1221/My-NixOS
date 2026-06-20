{
  pkgs,
  lib,
  nur,
  ...
}:
{
  options = {
    rustdesk = lib.mkOption {
      type = lib.types.package;
      default = (
        pkgs.rustdesk-flutter.overrideAttrs (old: {
          postPatch = old.postPatch or "" + ''
            substituteInPlace ../libs/scrap/src/wayland/pipewire.rs \
              --replace-fail "org.freedesktop.portal.Desktop" "org.freedesktop.portal.Desktop-for-rustdesk"
          '';
        })
      );
    };
  };
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
    ./firefox
    ./flatpak
    ./fuse
    ./genshin
    ./irc-server
    ./kubo
    ./libvirtd
    ./mihomo
    ./miner-cpu
    ./miner-gpu
    ./nix
    ./nix-ld
    ./ollama
    ./openssh
    ./qt
    # ./sing-box
    ./steam
    ./tailscale
    ./virutalbox
    ./waydroid
    ./yubikey

    ./root-utils.nix
  ];
}
