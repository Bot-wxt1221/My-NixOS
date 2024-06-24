{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse3
    curl
    crypto
    fuse2
    glib
  ];
}
