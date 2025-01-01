{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.file.".config/fcitx5" = {
    source = ./fcitx5;
  };
}
