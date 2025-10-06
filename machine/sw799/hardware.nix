{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./sops
  ];
  disko = {
    enableConfig = true;
    bootImage = {
      fileSystem = "btrfs";
      espStart = "16M";
      uboot.enable = true;
      uboot.package = pkgs.callPackage ./uboot.nix { };
    };
  };

  hardware = {
    firmware = [ (pkgs.callPackage ./brcmfmac-firmware.nix { }) ];
    serial = {
      enable = true;
      unit = 2;
      baudrate = 1500000;
    };
  };

  nixpkgs.overlays = [
    (self: pkgs: {
      makePatch =
        {
          name ? "unnamed",
          src,
          patchCommands,
        }:
        pkgs.runCommand "${name}.patch" { inherit src; } ''
          unpackPhase

          orig=$sourceRoot
          new=$sourceRoot-modded
          cp -r $orig/. $new/

          pushd $new >/dev/null
          ${patchCommands}
          popd >/dev/null

          diff -Naur $orig $new > $out || true
        '';

      buildUBoot =
        { defconfig, ... }@args:
        (pkgs.buildUBoot args).overrideAttrs {
          configurePhase = ''
            runHook preConfigure

            cat $extraConfigPath >> configs/${defconfig}

            make ${defconfig}

            runHook postConfigure
          '';
        };

      buildLinux =
        let
          kernalArch =
            if pkgs.stdenv.hostPlatform.linuxArch == "x86_64" then
              "x86"
            else
              pkgs.stdenv.hostPlatform.linuxArch;
        in
        {
          defconfigFile ? null,
          ...
        }@args:
        (pkgs.buildLinux args).override (prev: {
          defconfig = if isNull defconfigFile then prev.defconfig or null else "fromfile_defconfig";
          kernelPatches =
            prev.kernelPatches or [ ]
            ++ pkgs.lib.optional (!(isNull defconfigFile)) {
              name = "symlink-defconfigFile-to-kernel-defconfig";
              patch = self.makePatch {
                src = pkgs.emptyDirectory;
                patchCommands = ''
                  mkdir -p arch/${kernalArch}/configs
                  ln -s ${defconfigFile} arch/${kernalArch}/configs/fromfile_defconfig
                '';
              };
            };
        });
    })
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "net.ifnames=0"
      "console=tty1"
      "earlycon"
    ];
    loader.grub.enable = true;
  };

}
