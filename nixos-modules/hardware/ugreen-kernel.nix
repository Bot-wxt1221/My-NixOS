{
  stdenv,
  kernel,
  kernelModuleMakeFlags,
}:
stdenv.mkDerivation {
  version = "1.6";
  pname = "ugreen";

  src = ./ugreen-driver/aic8800_linux_drvier/drivers/aic8800;

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernelModuleMakeFlags ++ [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  env.CFLAGS = toString [
    "-Wno-error"
  ];

  installPhase = ''
    install -D aic_load_fw/aic_load_fw.ko $out/lib/modules/${kernel.modDirVersion}/misc/aic_load_fw.ko
    install -D aic8800_fdrv/aic8800_fdrv.ko $out/lib/modules/${kernel.modDirVersion}/misc/aic8800_fdrv.ko
  '';

}
