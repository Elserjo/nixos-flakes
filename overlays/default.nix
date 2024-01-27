{ inputs, ... }:

{
  modifications = final: prev: {
    tdesktop-no-ads = prev.tdesktop.overrideAttrs
      (old: { patches = old.patches ++ [ ../patches/tdesktop-no-ads.patch ]; });

    # https://elatov.github.io/2022/01/building-a-nix-package/
    # For qt libs we should append libsForQt5 before callPackage
    flacon-with-ape = prev.libsForQt5.callPackage ../packages/flacon.nix { };

    # Just an example how to pin specific package version
    # picard = prev.picard.overrideAttrs (_: super: {
    #   src = final.fetchFromGitHub {
    #     owner = "metabrainz";
    #     repo = "picard";
    #     rev = "2.8.4";
    #     hash = "sha256-ygZkj7hZNm7XyqDEI7l49d36ZgCTwFiAuYZjlF9d5+8=";
    #   };
    # });
  };
}
