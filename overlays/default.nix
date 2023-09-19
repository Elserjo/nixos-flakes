{ inputs, ... }:

{
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs { system = final.system; };
  };
  modifications = final: prev: {
    tdesktop-no-ads = prev.tdesktop.overrideAttrs (old: {
      patches = old.patches ++ [
        ../patches/tdesktop-no-ads.patch
      ];
    });
  };
}
