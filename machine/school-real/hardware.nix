{
  config,
  lib,
  pkgs,
  nixos-facter-modules,
  ...
}:

{
  imports = [
    ./school-real-hardware-configuration.nix
    ./sops
    nixos-facter-modules.nixosModules.facter
  ];
  facter.reportPath = ./factor-school-real.json;
  boot.initrd.kernelModules = [
    "i915"
    "vfio-iommu-type1"
    "kvmgt"
    "mdev"
    "bcache"
    "snd_aloop"
  ];
  services.fstrim.enable = lib.mkDefault true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libva
      libvdpau-va-gl
      vaapiVdpau
      ocl-icd
      intel-ocl
      intel-compute-runtime-legacy1
      intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    bcachefs-tools = pkgs.bcachefs-tools.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "koverstreet";
        repo = "bcachefs-tools";
        rev = "5023292623e8f1dedc138a20daabbcc4772a0d86";
        hash = "sha256-TuYMttih+FtQ+nuENaigVKFE6cKB9VU2725ILN3vRIE=";

      };
      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        src = pkgs.fetchFromGitHub {
          owner = "koverstreet";
          repo = "bcachefs-tools";
          rev = "5023292623e8f1dedc138a20daabbcc4772a0d86";
          hash = "sha256-TuYMttih+FtQ+nuENaigVKFE6cKB9VU2725ILN3vRIE=";

        };
        hash = "sha256-dayYLzoCcNbL5TcfxwlKx+7zK3LHLF3j1w1C9ZzsMuE=";
      };
    });
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    QT_QPA_PLATFORM = "wayland";
  };
  boot.kernelParams = [
    "intel_iommu=on"
    "i915.enable_guc=3"
    "i915.enable_fbc=1"
    "i915.enable_execlists=0"
    "modprobe.blacklist=rtw88_8821ce"
  ];
  services.xserver.videoDrivers = [
    "modesettings"
  ];
  boot.kernelModules = [
    "kvm-intel"
    "acpi_call"
    "v4l2loopback"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
    (v4l2loopback.overrideAttrs (old: {
      patches = old.patches or [ ] ++ [
        (pkgs.fetchpatch {
          url = "https://github.com/v4l2loopback/v4l2loopback/commit/196ae48c0f08dfcdcad0aded4917cf8a303bf237.patch";
          hash = "sha256-gVeObdLdj6/YKD+TxjDC93G2cl2sz6z8qgGrQEOlkI8=";
        })
      ];
    }))
  ];
  environment.systemPackages = with pkgs; [
    bcache-tools
  ];
  systemd.tmpfiles.rules = [
    "w /sys/fs/bcache/*/congested_read_threshold_us  - - - - 20000"
    "w /sys/fs/bcache/*/congested_write_threshold_us - - - - 20000"
    "w /sys/block/bcache*/bcache/sequential_cutoff - - - - 131071" # 128KiB - 1B, defaults to 4MiB
    "w /sys/block/bcache*/bcache/cache_mode - - - - writeback"
  ];
}
