{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence = {
      url = "github:nix-community/impermanence";
    };

    neovim.url = "github:nix-community/neovim-nightly-overlay/master";
    neovim.inputs.nixpkgs.follows = "nixpkgs";

    nixVim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-colors.url = "github:misterio77/nix-colors";

    luogu-gcc.url = "github:luogu-dev/judge-env";
    clipboard = {
      url = "github:Bot-wxt1221/clipboard-sync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-source = {
      url = "github:YaLTeR/niri/078383ea8208337d3c9ea89118aa615d7fbbab17";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.niri-unstable.follows = "niri-source";
    };

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
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
    };
}
