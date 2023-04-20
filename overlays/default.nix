{ inputs, ... }:

{
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs { system = final.system; };
  };
}
