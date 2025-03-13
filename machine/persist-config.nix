{
  config,
  ...
}:
{
  imports = [

  ];

  fileSystems."/" = {
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };
  fileSystems."/nix" = {
    device = config.fileSystems."/".device;
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
    ];
  };
  fileSystems."/persist" = {
    device = config.fileSystems."/".device;
    fsType = "btrfs";
    options = [
      "subvol=persist"
    ];
  };
}
