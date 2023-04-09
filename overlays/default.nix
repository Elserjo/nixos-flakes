final: prev:
{
  system = "x86_64-linux";
  unstable = nixpkgs.legacyPackages.${prev.system};
};
