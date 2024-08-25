{ configs, pkgs, ... }:
let
  sources-qq = import ./sources-qq.nix;
  srcs-qq = {
    x86_64-linux = pkgs.fetchurl {
      url = sources-qq.amd64_url;
      hash = sources-qq.amd64_hash;
    };
    aarch64-linux = pkgs.fetchurl {
      url = sources-qq.arm64_url;
      hash = sources-qq.arm64_hash;
    };
  };
  src-nw-qq =
    srcs-qq.${pkgs.stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${pkgs.stdenv.hostPlatform.system}");
in
{
  imports = [

  ];
  home.packages = with pkgs; [
    cachix
    neofetch
    konsole
    gnome.gnome-logs
    kitty
    helvum
    gnome-graphs
    cpu-x
    nautilus
    weston
    file-roller
    pigz
    nixfmt-rfc-style
    wayvnc
    realvnc-vnc-viewer
      (pkgs.bilibili.overrideAttrs {
        src = pkgs.fetchurl {
          url = "https://github.com/msojocs/bilibili-linux/releases/download/v1.14.0-2/io.github.msojocs.bilibili_1.14.0-2_amd64.deb";
          hash = "sha256-QQMdEpKE7r/fPMaX/yEoaa7KjilhiPMYLRvGPkv1jds=";
        };
        installPhase = ''
          runHook preInstall

          mkdir -p $out/bin
          cp -r usr/share $out/share
          sed -i "s|Exec=.*|Exec=$out/bin/bilibili|" $out/share/applications/*.desktop
          cp -r opt/apps/io.github.msojocs.bilibili/files/bin/app $out/opt
          makeWrapper ${pkgs.electron_29}/bin/electron $out/bin/bilibili \
            --argv0 "bilibili" \
            --add-flags "$out/opt/app.asar" \
            --add-flags "--ozone-platform-hint=wayland --enable-wayland-ime"
          runHook postInstall
        '';
        unpackPhase = ''
          runHook preUnpack
          ${pkgs.dpkg}/bin/dpkg -x $src ./
          runHook postUnpack
        '';
      })
    wl-clipboard
    (pkgs.microsoft-edge.override {
      commandLineArgs = "--ozone-platform-hint=wayland --enable-wayland-ime --process-per-site --enable-zero-copy --enable-features=WebUIDarkMode,UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,WebRTCPipeWireCapturer,WaylandWindowDecorations";
    })
    (
      (pkgs.qq.override { commandLineArgs = "--ozone-platform-hint=wayland --enable-wayland-ime"; })
      .overrideAttrs
      (previousAttrs: {
        src = src-nw-qq;
        version = sources-qq.version;
      })
    )
    resources
    obs-studio
    intel-gpu-tools
    vscode-extensions.ms-vscode.cpptools
    hmcl
    gnome-2048
    gh
    scrcpy
    android-tools
    zip
    xz
    obs-studio
    unzip
    p7zip
    spotify
    keepassxc
    motrix
    krdc
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    wpsoffice-cn
    glxinfo
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    alsa-firmware
    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    nix-output-monitor

    hugo # static site generator
    glow # markdown previewer in terminal

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
}
