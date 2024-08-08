let
in

{ lib, pkgs, ... }@args:

let
  version = "v6.11-rc2";
  src = lib.fetchzip {
    url = "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-6.11-rc2.tar.gz";
  };

  args' =
    (builtins.removeAttrs args [ "branch" ])
    // {
      inherit src version;

      modDirVersion = lib.versions.pad 3 version;
      extraMeta.branch = "mainline";
    }
    // (args.argsOverride or { });
in
buildLinux args'
