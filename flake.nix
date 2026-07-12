{
  inputs = {

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "release-26.05";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-26.05";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs = {nixpkgs.follows = "nixpkgs"; };
    };

    nix-darwin = {
      type = "github";
      owner = "nix-darwin";
      repo = "nix-darwin";
      ref = "nix-darwin-26.05";
      inputs = {nixpkgs.follows = "nixpkgs"; };
    };
  };

  outputs = 
    { ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      imports = [
        #./machines/amd64
        ./machines/darwin
      ];
   };
}
