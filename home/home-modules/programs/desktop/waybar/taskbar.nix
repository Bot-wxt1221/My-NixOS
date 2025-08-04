{
  rustPlatform,
  lib,
  fetchFromGitHub,
  pkg-config,
  gtk3,
  fetchpatch,
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

  cargoPatches = [
    (fetchpatch {
      url = "https://github.com/LawnGnome/niri-taskbar/pull/11/commits/472017164c0ce3ae8ab787317116bdc7afef23ec.patch";
      hash = "sha256-BicNVi2JHq9c7sEC3NSIuxIfTg5TMjOzQw/PyLUqhLQ=";
    })
  ];

  cargoHash = "sha256-NTiXr9FrcKWwfY7uV8yTSSNKbrCmKT7dVQp9m2U98UQ=";

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
