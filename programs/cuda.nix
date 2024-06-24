{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  envionment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
  ];
  environment.sessionVariables = rec {
    CUDA_PATH = "${pkgs.cudatoolkit}";
  };
}
