{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    gcc
    gdb
    gnumake
    vscode-extensions.ms-vscode.cpptools
    cmake
  ];
}
