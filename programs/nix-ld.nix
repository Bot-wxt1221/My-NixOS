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
  programs.nix-ld.libraries =
    with pkgs;
    lib.mkMerge [
      [
        fuse3
        curl
        gtk3
        openssl
        fuse2
        ocl-icd
        glib
        nss
      ]
<<<<<<< HEAD
      (lib.mkIf (config.hardware.nvidia.modesetting.enable) [
#        cudaPackages.cudatoolkit
#        linuxPackages.nvidia_x11
=======
      (lib.mkIf config.hardware.nvidia.modesetting.enable [
        cudaPackages.cudatoolkit
        linuxPackages.nvidia_x11
>>>>>>> cf9fc14042d908ff69726fdb11d3219154d0c42e
      ])
    ];
}
