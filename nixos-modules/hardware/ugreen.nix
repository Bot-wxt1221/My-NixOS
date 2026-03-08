{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.udev.extraRules = ''
    KERNEL=="sd*", ATTRS{idVendor}=="a69c", ATTRS{idProduct}=="5721",  SYMLINK+="aicudisk", RUN+="${lib.getExe' pkgs.util-linux "eject"} /dev/%k"
    KERNEL=="sd*", ATTRS{idVendor}=="a69c", ATTRS{idProduct}=="5722",  SYMLINK+="aicudiskv2", RUN+="${lib.getExe' pkgs.util-linux "eject"} /dev/%k"
    KERNEL=="sd*", ATTRS{idVendor}=="a69c", ATTRS{idProduct}=="572a",  SYMLINK+="aicudiskv3", RUN+="${lib.getExe' pkgs.util-linux "eject"} /dev/%k"
  '';
  environment.systemPackages = [
    (pkgs.stdenvNoCC.mkDerivation {
      pname = "ugreen-firmware";
      version = "1.6";
      src = ./ugreen-driver;
      dontStrip = true;
      postInstall = ''
        mkdir -p $out/lib/firmware
        cp -rf $src/aic8800_linux_drvier/fw/aic8800DC $out/lib/firmware/
      '';
    })
  ];
  boot.extraModulePackages = [
    (pkgs.callPackage ./ugreen-kernel.nix {
      kernel = config.boot.kernelPackages.kernel;
      kernelModuleMakeFlags = config.boot.kernelPackages.kernelModuleMakeFlags;
    })
  ];
}
