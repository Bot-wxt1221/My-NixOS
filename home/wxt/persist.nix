{
  config,
  lib,
  pkgs,
  impermanence,
  ...
}:
{
  imports = [
    impermanence.homeManagerModules.impermanence
  ];
  home.persistence."/persist/home/wxt" = {
    enable = true;
    directories = [
      "Downloads"
      "Music"
      "Working"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".local/share/zsh"
      ".wakatime.cfg"
      ".wakatime"

      ".local/share/io.github.clash-verge-rev.clash-verge-rev"
      ".local/share/clash-verge"

      ".local/share/fcitx5"
      ".config/QQ"
      ".config/microsoft-edge"

      ".local/share/nvim"
      ".local/share/keyrings"
      ".local/state/nvim"

      ".local/share/fractal"
      ".cache/fractal"

      ".zplug"

      ".config/bilibili"
    ];
    allowOther = true;
  };
}
