{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.unfree.nix;
in {
  options.modules.unfree.nix.allowedUnfreePackages = mkOption {
    type = with types; listOf str;
    default = [ ];
  };

  config = {
    nixpkgs = {
      config.allowUnfreePredicate = p:
        elem (getName p) cfg.allowedUnfreePackages;
    };
  };
}
