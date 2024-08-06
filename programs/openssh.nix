{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  users.users."wxt".openssh.authorizedKeys.keyFiles = [ ./authorized_keys ];
}
