{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
