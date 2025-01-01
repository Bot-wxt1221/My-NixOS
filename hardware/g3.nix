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
    package = config.boot.kernelPackages.nvidiaPackages.beta;
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
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/etc/bluetooth"
      "/var/lib/cups"
      "/var/lib/NetworkManager"
      "/var/lib/libvirt"
      "/var/lib/waydroid"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];
  };
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/nvme0n1p3 /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +1); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

}
