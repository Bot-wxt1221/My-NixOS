{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./bazhong-hardware-configuration.nix
    ../system/laptop.nix
    ../system/libinput.nix
    ./persist-config.nix
  ];
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
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
    ];
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
  ];
  services.xserver.videoDrivers = [
    "modesettings"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    (acpi_call.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + "export buildRoot=.";
    }))
  ];
}
