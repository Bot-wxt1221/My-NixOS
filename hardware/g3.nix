{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./g3-hardware-configuration.nix
  ];
  boot.initrd.kernelModules = ["i915" "vfio-iommu-type1" "kvmgt" "mdev" "acpi_call" "snd_aloop"];
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
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  boot.extraModprobeConfig = ''
    options snd-aloop enable=1,1,1,1,1,1,1,1
  '';
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; 
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
      	enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
  boot.kernelParams = [ "intel_iommu=on" "i915.enable_guc=3" "nvidia_drm.fbdev=1" "nvidia_drm.modeset=1" "i915.enable_fbc=1" "i915.enable_execlists=0" "i915.enable_gvt=1" "acpi_osi=Linux-Dell-Video" "hugepagesz=1GB" "default_hugepagesz=1GB" "hugepages=3"];
  services.xserver.videoDrivers = [ "modesettings" "nvidia" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
}
