{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/persist/".label = "persist";
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/NetworkManager"
      "/var/lib/libvirt"
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
  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.initrd.systemd.services.rollback = {
    description = "Reset BTRFS root subvolume to empty snapshot";
    # initrd target: root filesystem device is available but not yet mounted. So ensure that this happens in that window.
    wantedBy = [ "initrd.target" ];    
    # ensure the btrfs device is available
    requires = [  ];
    after = [  ];
    # ensure this happens before mounting root
    before = [ "sysroot.mount" ];
    # Don't establish any dependencies not defined here
    unitConfig.DefaultDependencies = "no";
    # run once and wait for completion before running subsequent systemd units
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir /btrfs_tmp
      mount ${config.fileSystems."/".device} /btrfs_tmp
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
  };
}
