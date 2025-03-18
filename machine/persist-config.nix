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
      "flushoncommit"
    ];
  };
  fileSystems."/nix" = {
    inherit (config.fileSystems."/") device;
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "flushoncommit"
    ];
  };
  fileSystems."/persist" = {
    inherit (config.fileSystems."/") device;
    fsType = "btrfs";
    options = [
      "subvol=persist"
      "flushoncommit"
    ];
  };
}
