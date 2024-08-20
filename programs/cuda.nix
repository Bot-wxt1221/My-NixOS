{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];
  options = {
    EnableCuda = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

  };
  config = lib.mkIf config.EnableCuda {
    environment.systemPackages = with pkgs; [
      cudatoolkit
      linuxPackages.nvidia_x11
    ];
    environment.sessionVariables = {
      CUDA_PATH = "${pkgs.cudatoolkit}";
    };
  };
}
