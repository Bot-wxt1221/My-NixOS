{
  config,
  ...
}:
{
  imports = [

  ];
  preservation.enable = true;
  boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  preservation.preserveAt."/persist" = {
    commonMountOptions = [
      "x-gvfs-hide"
    ];
    directories = [
      "/var/log"
      {
        directory = "/var/lib/nixos";
        inInitrd = true;
      }
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
      {
        file = "/etc/machine-id";
        inInitrd = true;
      }
    ];
  };
  # let the service commit the transient ID to the persistent volume
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persist/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persist"
    ];
  };
  boot.initrd.supportedFilesystems = [
    "btrfs"
    "bcachefs"
  ];
}
