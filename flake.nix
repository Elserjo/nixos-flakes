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
      inputs = {
        nixpkgs.follows = "nixpkgs-stable";
      };
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }:
    let
      system = "x86_64-linux";
      unstableOverlay = final: prev: {
        unstable = nixpkgs.legacyPackages.${prev.system};
      };
    in {
      nixosConfigurations.nixos = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ unstableOverlay ];
          })
          ./configuration.nix
        ];
      };
    };
}
