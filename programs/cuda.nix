{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
  ];
  #environment.sessionVariables = {
  #  CUDA_PATH = "${pkgs.cudatoolkit}";
  #};
}
