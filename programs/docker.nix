{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  virtualisation.docker.enable = true;
  users.users.wxt.extraGroups = ["docker"];
  environment.systemPackages = with pkgs; [
    docker
  ];
}
