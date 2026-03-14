{
  stdenv,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
  bc,
}:

stdenv.mkDerivation {
  pname = "rtl8188eus-aircrack";
  version = "${kernel.version}-unstable-2024-09-18";
  makeFlags = kernelModuleMakeFlags;
  src = fetchFromGitHub {
    owner = "aircrack-ng";
    repo = "rtl8188eus";
    rev = "f969c544ab6100da3d80a5709e077f920f2df698";
    hash = "sha256-uwO2nDDff4t0PZw3mLWmUPOHHftDgoaBaWMXQKHQunI=";
  };

  prePatch = ''
    substituteInPlace ./Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace /sbin/depmod \# \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  hardeningDisable = [ "pic" ];

  enableParallelBuilding = true;

  nativeBuildInputs = [ bc ] ++ kernel.moduleBuildDependencies;

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';
}
