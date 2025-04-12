# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "bcache"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/eaeabb43-ef0c-467a-81db-d6685669e181";
    fsType = "bcachefs";
    options = [
      "X-mount.subdir=root"
    ];
    neededForBoot = true;
  };
  fileSystems."/nix" = {
    inherit (config.fileSystems."/") device;
    fsType = "bcachefs";
    depends = [
      "/"
    ];
    options = [
      "X-mount.subdir=nix"
    ];
    neededForBoot = true;
  };
  fileSystems."/persist" = {
    inherit (config.fileSystems."/") device;
    fsType = "bcachefs";
    depends = [ "/nix" ];
    options = [
      "X-mount.subdir=persist"
    ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5737-FC3A";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };
  systemd.services.systemd-remount-fs.enable = false;
  boot.initrd.systemd = {
    services.unlock-bcachefs--.enable = lib.mkForce false;
    services.unlock-bcachefs-nix.enable = lib.mkForce false;
    services.unlock-bcachefs-persist.enable = lib.mkForce false;
    services.rollback = {
      description = "Reset Bcachefs root subvolume to empty snapshot";
      wantedBy = [ "initrd.target" ];
      after = [ "initrd-root-device.target" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      serviceConfig.KeyringMode = "inherit";
      script = ''
        mkdir /btrfs_tmp
        systemd-ask-password --timeout=0 > /tmpkey
        until bcachefs mount --passphrase-file /tmpkey ${config.fileSystems."/".device} /btrfs_tmp
        do
          echo "<2> Password Error or Device Not Onlined. Try Again." > /dev/kmsg
          sleep 1
          systemd-ask-password --timeout=0 > /tmpkey
        done
        cd /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi
        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +1); do
          bcachefs subvolume del "$i"
        done
        ${pkgs.bcachefs-tools}/bin/bcachefs subvolume create root
        chmod 7777 root
        cd /
        umount /btrfs_tmp
      '';
    };
    emergencyAccess = true;
    enable = true;
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/6e8f7a22-0010-4c64-ba0f-a043c1e3b2c7"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
