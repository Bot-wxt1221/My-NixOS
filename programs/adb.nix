{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  users.users.wxt = {
    extraGroups = [ "adbusers" ];
  };
}
