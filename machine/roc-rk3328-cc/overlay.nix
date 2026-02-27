{ config, pkgs, ... }:

{
  hardware.deviceTree.enable = true;
  hardware.deviceTree.filter = "rk3399-roc-pc.dtb";
  hardware.deviceTree.overlays = [
    {
      name = "precompiled";
      dtsFile = ./rk3399-roc-pc.dtso;
    }
  ];
}
