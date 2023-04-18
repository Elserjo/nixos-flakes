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
      #unstableOverlay = final: prev: {
      #  unstable = nixpkgs.legacyPackages.${prev.system};
      #};
      nixosModules.common = import ./modules/common;
      overlays = import ./overlays/unstable.nix;
    in with nixosModules; {
      #formatter.${system} = nixpkgs-stable.legacyPackages.${system}.nixfmt;
      nixosConfigurations.nixos = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules = [
          common
          ./configuration.nix
        ];
      };
      homeConfigurations.serg = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-stable.legacyPackages.${system};
        modules = [
          ({ nixpkgs.overlays = [ unstableOverlay ]; })
          common
          ./home-manager/home.nix
          arkenfox-nixos.hmModules.arkenfox
        ];
      };
    };
}
