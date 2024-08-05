{
  description = "Main config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-src.url = "github:neovim/neovim";
    neovim-src.flake = false;
    neovim.url = "github:Bot-wxt1221/neovim-nightly-overlay/master";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
    neovim.inputs.neovim-src.follows = "neovim-src";
  };

  outputs = { self, nixpkgs, home-manager, neovim, ...}@inputs: {
    nixosConfigurations.wxt-g3 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit nixpkgs; };
      modules = [
       ./g3-configuration.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt;
      	    home-manager.extraSpecialArgs = {inherit neovim;};
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
      ];
    };
    nixosConfigurations.wxt-school-vmware = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit nixpkgs; };
      modules = [
       ./school-vmware-configuration.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wxt = import ./home/wxt;
      	    home-manager.extraSpecialArgs = {inherit neovim;};
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
      ];
    };
  };
}
