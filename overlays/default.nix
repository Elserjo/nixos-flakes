{ nixpkgs, nixpkgs-stable, ... }:

{
  unstableOverlay = final: prev: {
    unstable = nixpkgs.legacyPackages.${prev.system};
  };
}
