{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];
  security.sudo.wheelNeedsPassword = true;
}
