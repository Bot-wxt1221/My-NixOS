{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  virtualisation.kvmgt.enable = true;
  virtualisation.kvmgt.vgpus = {
    "i915-GVTg_V5_8" = {
      uuid = [ "53227488-1d02-11ef-be24-d3abbba451ea" ];
    };
  };
}
