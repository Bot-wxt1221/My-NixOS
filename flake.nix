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
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixVim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    clipboard = {
      url = "github:Bot-wxt1221/clipboard-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake/8bfb763f07fd9106e032590d071c30450e3b80f6";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sosp-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      neovim,
      niri,
      luogu-gcc,
      nix-colors,
      impermanence,
      clipboard,
      nixVim,
      nix-index-database,
      sops-nix,
      nixos-facter-modules,
      ...
    }@inputs:
    let
      HmSpecialArgs = {
        inherit
          clipboard
          nixVim
          luogu-gcc
          nix-colors
          impermanence
          neovim
          nix-index-database
          niri
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
          impermanence
          neovim
          nix-index-database
          niri
          sops-nix
          nixos-facter-modules
          ;
      };
    in
    {
      nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./g3-configuration.nix
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
          ./bazhong-configuration.nix
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
          ./school-vmware-configuration.nix
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
      nixosConfigurations.wxt-mininal-config = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = SystemSpecialArgs;
        modules = [
          ./mininal-desktop.nix
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-mininal-config.nix;
            home-manager.extraSpecialArgs = HmSpecialArgs;
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
          (
            {
              ...
            }:
            {
              environment.systemPackages = [
                self.nixosConfigurations.wxt-mininal-config.config.system.build.toplevel
              ];
            }
          )
        ];
      };
    };
}
