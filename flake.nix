{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-src.url = "github:neovim/neovim";
    neovim-src.flake = false;
    neovim.url = "github:nix-community/neovim-nightly-overlay/master";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    neovim.inputs.neovim-src.follows = "neovim-src";
    nvchad.url = "github:NvChad/nix";
    nvchad.inputs.nixpkgs.follows = "nixpkgs";
    starter.url = "github:Bot-wxt1221/Bot-wxt1221-NvChad";
    starter.flake = false;
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      neovim,
      nvchad,
      starter,
      ...
    }@inputs:
    {
      nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          nixpkgs = nixpkgs;
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
              inherit starter;
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
              inherit starter;
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}
