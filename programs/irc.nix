{
  pkgs,
  lib,
  config,
  ...
}:

{
  services.ngircd = {
    enable = true;
    config = builtins.readFile ./irc-config;
  };
  services.thelounge = {
    enable = true;
    public = true;
    plugins = [
      pkgs.theLoungePlugins.themes.solarized
    ];
  };
}
