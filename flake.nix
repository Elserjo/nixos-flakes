{
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
      ref = "release-24.05";
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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
    in
    {
      overlays = import ./overlays { inherit inputs; };
      # formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/nixos-host/configuration.nix ] ++ commonModules;
      };
      homeConfigurations.opensuse-pc =
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "${system}"; };
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/opensuse-pc/serg.nix ];
        };
    };
}
