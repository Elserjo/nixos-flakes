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
      ref = "release-22.11";
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
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs outputs; };
          home-manager.users.serg = import ./home-manager/home.nix;
        }
        arkenfox-nixos.hmModules.arkenfox
      ];
    in {
      #overlays = import ./overlays { inherit inputs; };
      nixosConfigurations.nixos = nixpkgs-stable.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ] ++ commonModules;
      };

      #homeConfigurations.serg = home-manager.lib.homeManagerConfiguration {
      #  pkgs = nixpkgs-stable.legacyPackages.${system};
      #  extraSpecialArgs = { inherit inputs outputs; };
      #  modules =
      #    [ common ./home-manager/home.nix arkenfox-nixos.hmModules.arkenfox ];
      #};
    };
}
