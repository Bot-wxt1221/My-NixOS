{
  config,
  lib,
  pkgs,
  nixos-facter-modules,
  ...
}:

{
  imports = [
    ./g3-hardware-configuration.nix
    ./sops
    nixos-facter-modules.nixosModules.facter
  ];
  boot.initrd.kernelModules = [
    "i915"
    "vfio-iommu-type1"
    "kvmgt"
    "mdev"
    "snd_aloop"
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  nixpkgs.config.cudaSupport = false;
  services.hardware.bolt.enable = true;
  services.fstrim.enable = lib.mkDefault true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libva
      libvdpau-va-gl
      libva-vdpau-driver
      ocl-icd
      intel-ocl
      # intel-compute-runtime-legacy1
      nvidia-vaapi-driver
      intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva-vdpau-driver
      libvdpau-va-gl
      intel-media-driver
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    QT_QPA_PLATFORM = "wayland";
    GSK_RENDERER = "gl";
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaPersistenced = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    videoAcceleration = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
  specialisation = {
    nvidia-passthru = {
      inheritParentConfig = true;
      configuration = {
        hardware.nvidia = lib.mkForce { };
        services.xserver.videoDrivers = lib.mkForce [ "modesetting"];
        boot.kernelParams = [
          "modprobe.blacklist=nvidia,nvidia_drm,nvidia_modeset,nvidia_uvm,nouveau"
          "iommu=pt"
          "intremap=no_x2apic_optout"
          "vfio-pci.ids=10de:10fa,10de:1f91"
        ];
        boot.blacklistedKernelModules = [
          "nvidia"
          "nvidia_nvm"
          "nvidia_drm"
          "nvidia_modeset"
          "nouveau"
        ];
      };
    };
  };
  boot.kernelParams = [
    "intel_iommu=on"
    "i915.enable_guc=3"
    "i915.enable_fbc=1"
    "i915.enable_execlists=0"
    "acpi_osi=Linux-Dell-Video"
  ];
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  boot.kernelModules = [
    "kvm-intel"
    "acpi_call"
    "v4l2loopback"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
    v4l2loopback
  ];
}
