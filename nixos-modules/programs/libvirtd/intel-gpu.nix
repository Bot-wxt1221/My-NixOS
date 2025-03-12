{
  config,
  lib,
  ...
}:

lib.mkIf ((lib.lists.count (x: x.driver == "i915") config.facter.report.hardware.graphics_card) > 0)
  {
    virtualisation.kvmgt.enable = true;
    virtualisation.kvmgt.vgpus = {
      "i915-GVTg_V5_4" = {
        uuid = [ "a9e82ce4-e116-11ef-a82e-23078161a38b" ];
      };
    };
  }
