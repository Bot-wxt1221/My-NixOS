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
    yazi
    konsole
    fd
    gnome-logs
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
    bilibili
    wl-clipboard
    (pkgs.microsoft-edge.override {
      commandLineArgs = "--process-per-site --ozone-platform-hint=wayland --enable-wayland-ime --wayland-text-input-version=3";
    })
    #  (
    #    (pkgs.qq.override { commandLineArgs = "--ozone-platform-hint=wayland --enable-wayland-ime --wayland-text-input-version=3"; })
    #     .overrideAttrs
    #     (previousAttrs: {
    #       src = src-nw-qq;
    #       version = sources-qq.version;
    #     })
    #   )
    qq
    resources
    obs-studio
    intel-gpu-tools
    hmcl
    gh
    scrcpy
    android-tools
    fractal
    zip
    xz
    obs-studio
    unzip
    p7zip
    spotify
    keepassxc
    motrix
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
