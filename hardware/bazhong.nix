{
  config,
  lib,
  pkgs,
  modulesPath,
  nixos-facter-modules,
  ...
}:

{
  imports = [
    ./bazhong-hardware-configuration.nix
    ../system/laptop.nix
    ../system/libinput.nix
    ./persist-config.nix
    nixos-facter-modules.nixosModules.facter
  ];
  facter.reportPath = ./facter-bazhong.json;
  boot.initrd.kernelModules = [
    "i915"
    "vfio-iommu-type1"
    "kvmgt"
    "mdev"
    "acpi_call"
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
      intel-compute-runtime
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
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    (rtl8821ce.overrideAttrs (old: {
      env.NIX_CFLAGS_COMPILE = toString [
        "-Wno-error=incompatible-pointer-types"
      ];
    }))
    (acpi_call.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + "export buildRoot=.";
    }))
  ];
}
