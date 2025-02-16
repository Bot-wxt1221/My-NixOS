{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
  ];
  home.persistence."/persist/home/wxt" = {
    directories = [
      ".wakatime"

      ".local/share/io.github.clash-verge-rev.clash-verge-rev"
      ".local/share/clash-verge"

      ".local/share/fcitx5"
      ".config/microsoft-edge"

      ".local/share/keyrings"

      ".local/share/fractal"
      ".cache/fractal"

      ".zplug"

      ".config/bilibili"

      ".config/pulse"
      ".config/keepassxc"

      ".cache/dconf"
      ".config/dconf"
      ".local/share/flatpak"
      ".var"
    ];
    files = [
      ".wakatime.cfg"
      ".config/keepassxc/keepassxc.ini"
    ];
  };
}
