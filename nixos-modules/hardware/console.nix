{
  pkgs,
  ...
}:
{
  imports = [

  ];
  i18n.defaultLocale = "zh_CN.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.kbd}/share/consolefonts/Lat2-Terminus16.psfu.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
