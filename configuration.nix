# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./desktop.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  security.sudo.wheelNeedsPassword = false;
  virtualisation.docker.enable = true;
  boot.loader.grub.device = "nodev";
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rt_6_9;
  services.flatpak.enable = true;
  boot.loader.grub.efiSupport = true;
  networking.hostName = "wxt"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  virtualisation.waydroid.enable = true;
  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # networking.proxy.default = "http://127.0.0.1:7897/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
   };
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" "libvirtd" "docker"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    
  };
  # $ nix search wget
  services.todesk.enable = true;
  services.todesk.user = "wxt";
  programs.clash-verge.autoStart = true;
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    nano
    thefuck
    waydroid
    xclip todesk
    gcc (lowPrio clang) (lowPrio clang-tools) gdb gnumake lld vscode-extensions.ms-vscode.cpptools
    wget
    cmake
    alsa-firmware
    gnome.gnome-terminal dconf intel-gpu-tools
    linuxKernel.kernels.linux_rt_6_9 cpu-x
    gnome.gnome-tweaks
    clash-verge-rev virt-manager libvirt
  ] ;
  virtualisation.libvirtd.enable = true;
  virtualisation.vswitch.enable = true;
  systemd.services.clash-verge-rev = {
    enable = true;
    description = "clash verge rev";
    serviceConfig = {
      ExecStart = "${pkgs.clash-verge-rev}/lib/clash-verge/resources/clash-verge-service";
    };
    wantedBy = [ "multi-user.target" ];
  };
  nixpkgs.config.allowUnfree = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "unstable"; # Did you read the comment?
  nix.settings.substituters = ["https://mirrors.ustc.edu.cn/nix-channels/store" "https://nix-community.cachix.org"];
  nix.settings.trusted-users = ["root" "wxt"];
  nix.settings.trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
}
