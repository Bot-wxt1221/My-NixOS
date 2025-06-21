{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    an-anime-game-launcher = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    luogu-gcc.url = "github:luogu-dev/judge-env";
    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preservation = {
      url = "github:nix-community/preservation";
    };
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
    sops-nix = {
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
      nix-colors,
      preservation,
      clipboard,
      nixVim,
      nix-index-database,
      sops-nix,
      nixos-facter-modules,
      an-anime-game-launcher,
      ...
    }@inputs:
    let
      HmSpecialArgs = {
        inherit
          inputs
          clipboard
          nixVim
          luogu-gcc
          nix-colors
          nur
          preservation
          neovim
          nix-index-database
          sops-nix
          nixos-facter-modules
          an-anime-game-launcher
          ;
      };
      SystemSpecialArgs = {
        inherit
          inputs
          nixpkgs
          clipboard
          nixVim
          luogu-gcc
          nix-colors
          nur
          preservation
          neovim
          nix-index-database
          sops-nix
          nixos-facter-modules
          an-anime-game-launcher
          ;
      };
    in
    {
      nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./machine/g3
          preservation.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-g3.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
          }
        ];
      };
      nixosConfigurations.wxt-school-real = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./machine/school-real
          preservation.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-school-real.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
          }
        ];
      };
      packages.x86_64-linux.iso-image = self.nixosConfigurations.iso-image.config.system.build.isoImage;
      nixosConfigurations.iso-image = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs inputs;
        };
        modules = [
          ./iso
          ./nixos-modules/programs/nix
          (_: {
            boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
          })
        ];
      };
      packages.x86_64-linux.iso-image-gpu =
        self.nixosConfigurations.iso-image-gpu.config.system.build.isoImage;
      nixosConfigurations.iso-image-gpu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs inputs;
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
          inherit nixpkgs inputs;
        };
        modules = [
          ./iso
          (_: {
            environment.systemPackages = [
              self.nixosConfigurations.wxt-g3.config.system.build.toplevel
              self.nixosConfigurations.wxt-school-real.config.system.build.toplevel
            ];
          })
        ];
      };
    };
}
