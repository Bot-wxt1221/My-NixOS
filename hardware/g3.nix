{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./g3-hardware-configuration.nix
    ../system/intel.nix
    ../system/laptop.nix
    ../system/libinput.nix
    ../programs/cuda.nix
  ];
  boot.initrd.kernelModules = [
    "i915"
    "vfio-iommu-type1"
    "kvmgt"
    "mdev"
    "acpi_call"
    "snd_aloop"
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  nixpkgs.config.cudaSupport = true;
  services.hardware.bolt.enable = true;
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
      nvidia-vaapi-driver
      intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    QT_QPA_PLATFORM = "wayland";
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
  boot.kernelParams = [
    "intel_iommu=on"
    "i915.enable_guc=3"
    "nvidia_drm.fbdev=1"
    "nvidia_drm.modeset=1"
    "i915.enable_fbc=1"
    "i915.enable_execlists=0"
    "acpi_osi=Linux-Dell-Video"
  ];
  services.xserver.videoDrivers = [
    "modesettings"
    "nvidia"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
}
