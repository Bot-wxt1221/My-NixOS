{
  configs,
  pkgs,
  pkgs-main,
  ...
}:
{
  imports = [

  ];
  home.packages = with pkgs; [
    cachix
    fastfetch
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
    (qq.overrideAttrs (previousAttrs: {
      postInstall = ''
             rm -rf $out/bin/qq
              makeShellWrapper $out/opt/QQ/qq $out/bin/qq \
        --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH" \
        --prefix LD_PRELOAD : "${lib.makeLibraryPath [ pkgs.libssh2 ]}/libssh2.so.1" \
        --prefix LD_LIBRARY_PATH : "${
          lib.makeLibraryPath [
            pkgs.libGL
            pkgs.libuuid
          ]
        }" \
        "''${gappsWrapperArgs[@]}"
      '';
    }))
    #qq
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
    mtr # A network diagnostic tool
    iperf3
    project-lemonlime
    wpsoffice-cn
    glxinfo
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
