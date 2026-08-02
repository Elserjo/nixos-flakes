{
  inputs = {

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "master";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
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
      ref = "master";
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
