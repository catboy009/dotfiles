{
  description = "Nix Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grc-rs = {
      url = "github:catboy009/grc-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs: {
    darwinConfigurations."catbook" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/catbook.nix
        home-manager.darwinModules.home-manager
        ({ ... }: {
          nix.registry.nixpkgs.flake = inputs.nixpkgs;
          services.nix-daemon.enable = true;
          security.pam.enableSudoTouchIdAuth = true;
          nixpkgs.config.allowUnfree = true;
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.catboy.imports = [ ./home ];
          };
        })
      ];
    };
  };
}
