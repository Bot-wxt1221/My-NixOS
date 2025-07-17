{
  pkgs,
  ...
}:
{
  boot.kernelModules = [ "ntsync" ];

  # make ntsync device accessible
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "ntsync-udev-rules";
      text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
      destination = "/etc/udev/rules.d/70-ntsync.rules";
    })
  ];
}
