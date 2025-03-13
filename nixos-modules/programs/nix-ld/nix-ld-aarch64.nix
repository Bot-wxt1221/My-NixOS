{
  config,
  lib,
  nixpkgs,
  ...
}:
let
  pkgsAarch64 = import nixpkgs { system = "aarch64-linux"; };

  nix-ld-libraries-aarch64 = pkgsAarch64.buildEnv {
    name = "ld-library-path";
    pathsToLink = [ "/lib" ];
    paths = map lib.getLib (
      import ./nix-ld-list.nix {
        pkgs = pkgsAarch64;
        inherit config lib;
      }
    );
    # TODO make glibc here configurable?
    postBuild = ''
      ln -s ${pkgsAarch64.stdenv.cc.bintools.dynamicLinker} $out/share/nix-ld-aarch64/lib/ld.so
    '';
    extraPrefix = "/share/nix-ld-aarch64";
    ignoreCollisions = true;
  };
in
lib.mkIf (lib.lists.any (x: x == "aarch64-linux") config.boot.binfmt.emulatedSystems) {
  environment.systemPackages = [
    nix-ld-libraries-aarch64
  ];
  environment.pathsToLink = [ "/share/nix-ld-aarch64" ];
  environment.sessionVariables = {
    NIX_LD_aarch64_linux = "/run/current-system/sw/share/nix-ld-aarch64/lib/ld.so";
    NIX_LD_LIBRARY_PATH_aarch64_linux = "/run/current-system/sw/share/nix-ld-aarch64/lib";
  };
  systemd.tmpfiles.rules = [
    "d /lib 0755 root root - -"
    "L+ /lib/ld-linux-aarch64.so.1 - - - - ${pkgsAarch64.nix-ld}/libexec/nix-ld"
  ];
}
