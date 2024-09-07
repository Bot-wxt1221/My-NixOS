{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-main.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-src.url = "github:neovim/neovim";
    neovim-src.flake = false;
    neovim.url = "github:nix-community/neovim-nightly-overlay/master";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    neovim.inputs.neovim-src.follows = "neovim-src";
    nvchad.url = "github:nix-community/nix4nvchad";
    nvchad.inputs.nixpkgs.follows = "nixpkgs";
    starter.url = "github:Bot-wxt1221/Bot-wxt1221-NvChad";
    starter.flake = false;
    nvchad.inputs.nvchad-starter.follows = "starter";
    luogu-gcc.url = "github:luogu-dev/judge-env";
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?rev=016da234d0e852de3ef20eb2e89ac58d2a85f6e7&submodules=1&branch=main";
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
      luogu-gcc,
      hyprland,
      ...
    }@inputs:
    {
      nixpkgs.overlays = [
        hyprland.overlays.default
      ];
      nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          nixpkgs = nixpkgs;
          hyprland = hyprland;
          pkgs-main = import nixpkgs-main {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./g3-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-g3.nix;
            home-manager.extraSpecialArgs = {
              inherit neovim;
              inherit nvchad;
              inherit luogu-gcc hyprland;
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
          nixpkgs = nixpkgs;
          hyprland = hyprland;
          pkgs-main = import nixpkgs-main {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./school-vmware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt/default-school-vmware.nix;
            home-manager.extraSpecialArgs = {
              inherit neovim;
              inherit nvchad;
              inherit luogu-gcc hyprland;
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
