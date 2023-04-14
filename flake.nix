{
  description = "My test of nix flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    nixpkgs-stable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "release-22.11";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs = { nixpkgs.follows = "nixpkgs-stable"; };
    };

    arkenfox-nixos = {
      type = "github";
      owner = "dwarfmaster";
      repo = "arkenfox-nixos";
      ref = "main";
      inputs = { nixpkgs.follows = "nixpkgs-stable"; };
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, arkenfox-nixos }:
    let
      system = "x86_64-linux";
      unstableOverlay = final: prev: {
        unstable = nixpkgs.legacyPackages.${prev.system};
      };
    in {
      nixosConfigurations.nixos = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules =
          [ ({ nixpkgs.overlays = [ unstableOverlay ]; }) ./configuration.nix ];
      };
      homeConfigurations.serg = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-stable.legacyPackages.${system};
        modules = [ ./home-manager/home.nix arkenfox-nixos.hmModules.arkenfox ];
      };
    };
}
