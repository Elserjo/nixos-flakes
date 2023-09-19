{ inputs, ... }:

{
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs { system = final.system; };
  };
  modifications = final: prev: {
    tdesktop = prev.tdesktop.overrideAttrs (old: {
      patches = [
        ./patches/tdesktop-no-ads.patch
      ];
    });
  };
}
