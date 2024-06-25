{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    fuse3
    curl
    gtk3
    openssl
    fuse2
    glib
    nss
    cudaPackages.cudatoolkit
    linuxPackages.nvidia_x11
  ];
}
