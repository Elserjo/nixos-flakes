{ inputs, ... }:

{
  modifications = final: prev: {
    tdesktop-no-ads = prev.tdesktop.overrideAttrs
      (old: { patches = old.patches ++ [ ../patches/tdesktop-no-ads.patch ]; });
    cmus = prev.cmus.overrideAttrs (old: {
      src = final.fetchFromGitHub {
        owner = "cmus";
        repo = "cmus";
        rev = "23afab39902d3d97c47697196b07581305337529";
        sha256 = "sha256-pxDIYbeJMoaAuErCghWJpDSh1WbYbhgJ7+ca5WLCrOs=";
      };
      # We don't need patches anymore
      patches = [ ];
    });
  };
}
