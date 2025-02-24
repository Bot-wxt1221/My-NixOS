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
}
