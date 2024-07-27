{configs ,pkgs ,...}:
{
  imports = [

  ];
  bilibili-edit=pkgs.bilibili.overrideAttrs{
    src = pkgs.fetchurl {
      url = "https://github.com/msojocs/bilibili-linux/releases/download/v1.14.0-1/io.github.msojocs.bilibili_1.14.0-1_amd64.deb";
      hash = "sha256-iflq6Rgj5PUvtIJ2FCBO4ki8Tf6LNHZrxKXKYjqD/Qo=";
    };
  };
  home.packages = with pkgs;[
    cachix
    neofetch
    rustdesk-flutter
    helvum
    cpu-x
    weston
    bilibili-edit
    microsoft-edge
    qq
    resources
    obs-studio
    intel-gpu-tools
    xclip
    vscode-extensions.ms-vscode.cpptools 
    hmcl
    gnome-2048
    gh
    scrcpy
    android-tools
    zip
    xz obs-studio
    unzip     
    p7zip spotify
    keepassxc
    motrix
    krdc
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3 wpsoffice-cn glxinfo
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
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

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
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
