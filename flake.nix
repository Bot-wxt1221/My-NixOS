{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-colors.url = "github:misterio77/nix-colors";
    luogu-gcc.url = "github:luogu-dev/judge-env";
    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    nixinate.url = "github:matthewcroughan/nixinate";
    nixinate.inputs.nixpkgs.follows = "nixpkgs";
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixVim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    clipboard = {
      url = "github:Bot-wxt1221/clipboard-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sosp-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nur,
      home-manager,
      neovim,
      luogu-gcc,
      nixinate,
      nix-colors,
      impermanence,
      clipboard,
      nixVim,
      nix-index-database,
      sops-nix,
      nixos-facter-modules,
      ...
    }:
    let
      HmSpecialArgs = {
        inherit
          clipboard
          nixVim
          luogu-gcc
          nix-colors
          nur
          impermanence
          neovim
          nix-index-database
          sops-nix
          nixos-facter-modules
          ;
      };
      SystemSpecialArgs = {
        inherit
          nixpkgs
          clipboard
          nixVim
          luogu-gcc
          nix-colors
          nur
          impermanence
          neovim
          nix-index-database
          sops-nix
          nixos-facter-modules
          ;
      };
    in
    {
      apps = nixinate.nixinate.x86_64-linux self;
      nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./machine/g3
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-g3.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
          }
        ];
      };
      nixosConfigurations.wxt-bazhong = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./machine/bazhong
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-bazhong.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
          }
        ];
      };
      nixosConfigurations.wxt-school-vmware = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./machine/school-vmware
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-school-vmware.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
          }
        ];
      };
      nixosConfigurations.wxt-school-real = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./machine/school-real
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-school-real.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
          }
          {
            _module.args.nixinate = {
              host = "192.168.41.128";
              sshUser = "root";
              buildOn = "local"; # valid args are "local" or "remote"
              substituteOnTarget = false; # if buildOn is "local" then it will substitute on the target, "-s"
              hermetic = false;
            };
          }
        ];
      };
      packages.x86_64-linux.iso-image = self.nixosConfigurations.iso-image.config.system.build.isoImage;
      nixosConfigurations.iso-image = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          ./iso
        ];
      };
      packages.x86_64-linux.iso-image-gpu =
        self.nixosConfigurations.iso-image-gpu.config.system.build.isoImage;
      nixosConfigurations.iso-image-gpu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          ./iso
          ./iso/gpu.nix
        ];
      };
      packages.x86_64-linux.iso-image-with-mininal-config =
        self.nixosConfigurations.iso-image-with-mininal-config.config.system.build.isoImage;
      nixosConfigurations.iso-image-with-mininal-config = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          ./iso
          (_: {
            environment.systemPackages = [
              self.nixosConfigurations.wxt-g3.config.system.build.toplevel
              self.nixosConfigurations.wxt-school-vmware.config.system.build.toplevel
              self.nixosConfigurations.wxt-bazhong.config.system.build.toplevel
              self.nixosConfigurations.wxt-school-real.config.system.build.toplevel
            ];
          })
        ];
      };
    };
}
