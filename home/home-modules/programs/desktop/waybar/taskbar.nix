{
  rustPlatform,
  lib,
  fetchFromGitHub,
  pkg-config,
  gtk3,
}:

rustPlatform.buildRustPackage rec {
  pname = "niri-taskbar";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "LawnGnome";
    repo = "niri-taskbar";
    tag = "v${version}";
    hash = "sha256-mzO2j3CnYJsF8UCoKquG2AT1Lb0PDsSEs2mdmTcTGPA=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-zOAdnkWSSJd2tfT1bV9WkFY74DKSGD6HkSl8a+Fyd9o=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    gtk3
  ];

  meta = {
    maintainers = with lib.maintainers; [ bot-wxt1221 ];
  };
}
