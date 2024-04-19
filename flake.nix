{
  description = "My test of nix flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nixpkgs-stable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "release-23.05";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    arkenfox-nixos = {
      type = "github";
      owner = "dwarfmaster";
      repo = "arkenfox-nixos";
      ref = "main";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    nix-flatpak = {
      type = "github";
      owner = "gmodena";
      repo = "nix-flatpak";
      ref = "main";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, arkenfox-nixos, nix-flatpak, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      commonModules = [ ./modules/common ] ++ [
        home-manager.nixosModules.home-manager
        {
          #Need for overlays and for allow unfree packages
          #inside homemanager module
          home-manager.useGlobalPkgs = false;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs outputs; };
          home-manager.sharedModules = [ ./modules/common ];
        }
      ];
    in {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/nixos-host/configuration.nix ] ++ commonModules;
      };
    };
}
