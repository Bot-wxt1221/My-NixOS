{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld-rs;
  programs.nix-ld.libraries = with pkgs; [
    fuse3
    curl
    gtk3
    openssl
    fuse2
    ocl-icd
    glib
    nss
  ];
}
