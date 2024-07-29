# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, nixpkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network/all.nix
      ./security/all.nix
      ./printing.nix
      ./font.nix
      ./programs/all.nix
      ./system/all.nix
    ];
systemd.services.todeskd = {
      description = "ToDesk Daemon Service";

      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
	"display-manager.service"
        "nss-lookup.target"
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.todesk}/bin/todesk service";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGINT $MAINPID";
        Restart = "on-failure";
        User = "root";
        Group = "root";
        WorkingDirectory = "/var/lib/todesk";
        StateDirectory = "todesk";
        StateDirectoryMode = "0777"; # Desktop application read /opt/todesk/config/config.ini. Such a pain!
#        ProtectSystem = "strict";
        ProtectHome = "read-only";
#        PrivateTmp = "yes";
        RemoveIPC = "yes";
      };
    };
  environment.systemPackages = [pkgs.todesk];
  time.timeZone = "Asia/Shanghai";
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "adbusers" "libvirtd"];
    packages = with pkgs; [
    ];  
  };
}
