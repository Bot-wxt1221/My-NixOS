{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #nixpkgs.url = "path:/home/wxt/nixpkgs/turn-rs";
    nixpkgs-main.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim.url = "github:nix-community/neovim-nightly-overlay/master";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    nvchad.url = "github:nix-community/nix4nvchad";
    nvchad.inputs.nixpkgs.follows = "nixpkgs";
    starter.url = "github:Bot-wxt1221/Bot-wxt1221-NvChad";
    starter.flake = false;
    nvchad.inputs.nvchad-starter.follows = "starter";
    luogu-gcc.url = "github:luogu-dev/judge-env";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-main,
      home-manager,
      neovim,
      nvchad,
      niri,
      luogu-gcc,
      ...
    }@inputs:
    {
      nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          niri = niri;
          nixpkgs = nixpkgs;
          pkgs-main = import nixpkgs-main {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./g3-configuration.nix
          niri.nixosModules.niri-flake
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-g3.nix;
            home-manager.extraSpecialArgs = {
              inherit neovim;
              inherit nvchad;
              inherit niri;
              inherit luogu-gcc;
              pkgs-main = import nixpkgs-main {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
      nixosConfigurations.wxt-school-vmware = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit niri;
          nixpkgs = nixpkgs;
          pkgs-main = import nixpkgs-main {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./school-vmware-configuration.nix
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-school-vmware.nix;
            home-manager.extraSpecialArgs = {
              inherit neovim;
              inherit nvchad;
              inherit niri;
              inherit luogu-gcc;
              pkgs-main = import nixpkgs-main {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}
