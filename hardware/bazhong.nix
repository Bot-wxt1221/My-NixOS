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
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_zen.rtl8821ce
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
    "modprobe.blacklist=rtw88_8821ce" 
  ];
  services.xserver.videoDrivers = [
    "modesettings"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821ce.overrideAttrs (old: {
      env.NIX_CFLAGS_COMPILE = toString[
        "-Wno-error=incompatible-pointer-types"
      ];
      })
    (acpi_call.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + "export buildRoot=.";
    }))
  ];
}
