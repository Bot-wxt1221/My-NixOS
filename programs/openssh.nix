{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  users.users."wxt".openssh.authorizedKeys.keyFiles = [
    /etc/nixos/ssh/authorized_keys
  ];
}
