{ inputs, ... }:

{
  modifications = final: prev: {
    tdesktop-no-ads = prev.tdesktop.overrideAttrs
      (old: { patches = old.patches ++ [ ../patches/tdesktop-no-ads.patch ]; });
  };
}
