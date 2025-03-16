{
  config,
  ...
}:
{
  preservation.preserveAt."/persist".users.wxt = {
    directories = [
      ".wakatime"

      ".local/share/io.github.clash-verge-rev.clash-verge-rev"
      ".local/share/clash-verge"

      ".local/share/zsh"

      ".local/share/fcitx5"

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

      ".config/gh"
    ];
    files = [
      ".wakatime.cfg"
      ".config/keepassxc/keepassxc.ini"
    ];
  };
}
