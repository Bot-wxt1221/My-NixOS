{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker
  ];
}
