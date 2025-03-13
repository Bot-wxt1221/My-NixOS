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
    inherit (config.fileSystems."/") device;
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
    ];
  };
  fileSystems."/persist" = {
    inherit (config.fileSystems."/") device;
    fsType = "btrfs";
    options = [
      "subvol=persist"
    ];
  };
}
