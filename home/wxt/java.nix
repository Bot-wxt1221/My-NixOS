{ config, pkgs, ... }:
{
  imports = [

  ];
  home.packages = with pkgs; [
    openjdk17-bootstrap
    maven
  ];
}
