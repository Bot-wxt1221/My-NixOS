{ pkgs, lib, ... }:
let
  createChromiumExtensionFor =
    browserVersion:
    {
      id,
      hash,
      version,
    }:
    {
      inherit id;
      crxPath = pkgs.fetchurl {
        url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
        name = "${id}.crx";
        inherit hash;
      };
      inherit version;
    };
  createChromiumExtension = createChromiumExtensionFor (
    lib.versions.major pkgs.ungoogled-chromium.version
  );
in
[
  (createChromiumExtension {
    # bilibili
    id = "kpbnombpnpcffllnianjibmpadjolanh";
    hash = "sha256-r1Gw3PngCjVscR1cdV/Cp5cqxZU/XnQ/3hQlpXOxiiY=";
    version = "2.8.19(Official)";
  })
  (createChromiumExtension {
    # Wayback Machine
    id = "fpnmgdkabkmnadcjpehmlllkndpkmiak";
    hash = "sha256-PSeBNFEN2dsC/FX2IigksnghOLLtXVZJI/nDYVZfz34=";
    version = "3.4.2";
  })
  (createChromiumExtension {
    # Turn off light for videos
    id = "bfbmjmiodbnnpllbbbfblcplfjjepjdn";
    version = "4.5.7";
    hash = "sha256-1L3D7lpMqlwlAkFH/qhkSgSQOp+aCBA/uzXrkFF6mOQ=";
  })
  (createChromiumExtension {
    # Tampermonkey
    id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";
    version = "5.3.3";
    hash = "sha256-ovAHUGgcJBX4tELTvSi7LS3zDSIK/v/2Wyz7vONsrs4=";
  })
  (createChromiumExtension {
    # CRX Extractor/Downloader
    id = "ajkhmmldknmfjnmeedkbkkojgobmljda";
    version = "1.5.8";
    hash = "sha256-SCv8JoXeA9Qzv5mHjlO9vNWaMDFVdOFCsXalvX7XxTM=";
  })
  (createChromiumExtension {
    # Carrot
    id = "gakohpplicjdhhfllilcjpfildodfnnn";
    version = "0.6.7";
    hash = "sha256-CLNPlcvIW3kHDUWKoNTZh3m7nzgd6bdc+5MlfW9jtDc=";
  })
  (createChromiumExtension {
    # Competitive Companion
    id = "cjnmckjndlpiamhfimnnjmnckgghkjbl";
    version = "2.60.0";
    hash = "sha256-pN/5ci/hF4UQHjHJzHrGdXiiuupwKPXYvuLPoZv7KPM=";
  })
  (createChromiumExtension {
    # KeePassXC
    id = "oboonakemofpalcgghocfoadofidjkkk";
    version = "1.9.6";
    hash = "sha256-raxuvQ0g/IqJWtU5bepqoGKMN+/UaYR5r4VIUU5pSus=";
  })
  (createChromiumExtension {
    # WakaTime
    id = "jnbbnacmeggbgdjgaoojpmhdlkkpblgi";
    version = "4.0.12";
    hash = "sha256-oWLxI8y8XQhTii/ZVNEOwXBpj6QnMiX3UTwlgX/Up+E=";
  })
]
