{
  config,
  ...
}:

{
  imports = [
    ./hardware.nix
    ../../nixos-modules
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-bazhong";
  Enablesteam = false;
  Enablepipewire = true;
  EnableWaydroid = true;
  EnableVirt = false;

  EnableOllama = true;
  EnableMineGPU = false;
  EnableVirtualBox = false;
  EnableBluetooth = true;
  EnableMineCPU = false;
  EnableCuda = false;
  EnableKubo = false;
  EnableDocker = true;
  Laptop = false;
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "libvirtd"
      "video"
      "networkmanager"
    ];
    hashedPasswordFile = config.sops.secrets.wxt-password.path;
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  #  specialisation = {
  #    test-kernel = {
  #      configuration = {
  #        system.nixos.tags = [ "test-kernel" ];
  #        boot.kernelPackages = pkgs.linuxPackagesFor (
  #          pkgs.buildLinux {
  #            version = "6.12-rc1";
  #            extraMeta.branch = "6.12";
  #            kernelPatches = [
  #              {
  #                name = "bridge-stp-helper";
  #                patch = "${nixpkgs}/pkgs/os-specific/linux/kernel/bridge-stp-helper.patch";
  #              }
  #              {
  #                name = "request-key-helper";
  #                patch = "${nixpkgs}/pkgs/os-specific/linux/kernel/request-key-helper.patch";
  #              }
  #            ];
  #            src = pkgs.fetchzip {
  #              url = "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-6.12-rc1.tar.gz";
  #              hash = "sha256-olfaNFVQD9qyF/5I0ynv2xa0zxQag/4jyLvZt5nc/Js=";
  #            };
  #          }
  #        );
  #      };
  #      inheritParentConfig = true;
  #    };
  #  };
}
