{
  pkgs,
  luogu-gcc,
  ...
}:
{
  home.file.".face".source = ./face;
  home.file."g++-9".source = "${luogu-gcc.packages.x86_64-linux.gcc-930}/bin/g++";
  home.file."g++-9".executable = true;
  home.packages = with pkgs; [
    nix-du
    cachix
    fastfetch
    yazi
    sops
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
    cpu-x
    nautilus
    gimp3-with-plugins
    gnome-calculator
    weston
    file-roller
    pigz
    nixfmt
    wayvnc
    realvnc-vnc-viewer
    bilibili
    wl-clipboard
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
    keepassxc
    motrix
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

    testlib
    ac-library

    feishu

    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    (rustdesk-flutter.overrideAttrs (old: {
      postPatch = old.postPatch or "" + ''
        substituteInPlace ../libs/scrap/src/wayland/pipewire.rs \
          --replace-fail "org.freedesktop.portal.Desktop" "org.freedesktop.portal.Desktop-for-rustdesk"
      '';
    }))
    discord
    telegram-desktop

    seahorse
    warp
  ];
}
