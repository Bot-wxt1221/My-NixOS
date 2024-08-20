{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./cuda-ld.nix ];
  options = {
    EnableCuda = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

  };
  config =
    lib.mkIf config.EnableCuda {
      environment.systemPackages = with pkgs; [
        cudatoolkit
        linuxPackages.nvidia_x11
      ];
      environment.sessionVariables = {
        CUDA_PATH = "${pkgs.cudatoolkit}";
      };
    }
    ++ lib.mkIf (config.programs.nix-ld.enable && config.EnableCuda) {
      programs.nix-ld.libraries = with pkgs; [
        cudaPackages.cudatoolkit
        linuxPackages.nvidia_x11
      ];
    };
}
