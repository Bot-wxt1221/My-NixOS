{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];
  config = lib.mkIf (config.programs.nix-ld.enable && config.EnableCuda) {
    programs.nix-ld.libraries = with pkgs; [
      cudaPackages.cudatoolkit
      linuxPackages.nvidia_x11
    ];
  };
}
