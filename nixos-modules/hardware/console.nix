{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  i18n.defaultLocale = "zh_CN.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
