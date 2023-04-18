{ nixpkgs, nixpkgs-stable, ... }:

{
  nixpkgs.overlays =
    [ (final: prev: { unstable = nixpkgs.legacyPackages.${prev.system}; }) ];
}
