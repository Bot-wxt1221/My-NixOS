{
  pkgs,
  luogu-gcc,
  ...
}:
{
  home.file."g++-9".source = "${luogu-gcc.packages.x86_64-linux.gcc-930}/bin/g++";
  home.file."g++-9".executable = true;
  home.packages = with pkgs; [
    nix-du
    cachix
    fastfetch
    yazi
    sops
    kdePackages.konversation
    kdePackages.konsole
    gcc
    gdb
    pkgs.nur.repos.bot-wxt1221.ddz_py
    wechat
    cmake
    gnumake
    fd
    gnome-logs
    helvum
    gnome-graphs
    nautilus
    gimp3-with-plugins
    gnome-calculator
    weston
    file-roller
    pigz
    nixfmt-rfc-style
    wayvnc
    bilibili
    wl-clipboard
    resources
    obs-studio
    gh
    scrcpy
    android-tools
    zip
    xz
    obs-studio
    unzip
    p7zip
    keepassxc
    ripgrep # recursively searches directories for a regex pattern
    mtr # A network diagnostic tool
    project-lemonlime
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    nix-output-monitor

    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    deadnix
    statix

    yubioath-flutter

    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
  ];
}
