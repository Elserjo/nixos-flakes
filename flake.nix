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
      ref = "release-23.05";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-23.05";
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

  outputs =
    { self, nixpkgs, nixpkgs-stable, home-manager, arkenfox-nixos, ... }@inputs:
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
          home-manager.users.serg = import ./home-manager;
        }
      ];
    in {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations.nixos = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/nixos-host/configuration.nix ] ++ commonModules;
      };
    };
}
