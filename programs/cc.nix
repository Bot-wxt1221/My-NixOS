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
    (lowPrio clang)
    (lowPrio clang-tools)
    gdb
    gnumake
    lld
    vscode-extensions.ms-vscode.cpptools
    cmake
  ];
}
