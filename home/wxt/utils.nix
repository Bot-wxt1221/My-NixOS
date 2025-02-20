{
  configs,
  pkgs,
  lib,
  luogu-gcc,
  ...
}:
{
  imports = [
  ];
  home.file."g++-9".source = "${luogu-gcc.packages.x86_64-linux.gcc-930}/bin/g++";
  home.file."g++-9".executable = true;
  home.packages = with pkgs; [
    cachix
    fastfetch
    yazi
    sops
    konsole
    gcc
    gdb
    cmake
    gnumake
    fd
    gnome-logs
    kitty
    helvum
    gnome-graphs
    cpu-x
    nautilus
    gimp-with-plugins
    gnome-calculator
    weston
    file-roller
    pigz
    nixfmt-rfc-style
    wayvnc
    realvnc-vnc-viewer
    bilibili
    (pkgs.microsoft-edge.override {
      commandLineArgs = "--process-per-site --ozone-platform-hint=wayland --enable-wayland-ime --wayland-text-input-version=3";
    })
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
    glxinfo
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
  ];
}
