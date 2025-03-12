{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nix-ld-aarch64.nix
  ];
  environment.sessionVariables = {
    NIX_LD_x86_64_linux = "/run/current-system/sw/share/nix-ld/lib/ld.so";
    NIX_LD_LIBRARY_PATH_x86_64_linux = "/run/current-system/sw/share/nix-ld/lib";
    NIX_LD = lib.mkForce "";
    NIX_LD_LIBRARY_PATH = lib.mkForce "";
  };
  environment.extraInit = ''
    # Avoid influence on aarch64 set NIX_LD_x86_64_linux instead
    unset NIX_LD
    unset NIX_LD_LIBRARY_PATH
  '';
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = import ./nix-ld-list.nix {
    inherit pkgs config lib;
  };
}
