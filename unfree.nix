{ lib, pkgs, ... }:

{
  imports = [./modules/unfree.nix];
  
  #nixpkgs.config.allowUnfreePredicate = pkg:
  #  builtins.elem (lib.getName pkg) [
  #    "Oracle_VM_VirtualBox_Extension_Pack"
  #    "steam"
  #    "steam-original"
  #    "steam-run"
  #    "steam-runtime"
  #  ];

  modules.unfree.nix.allowedUnfreePackages = [ "steam"
                                               "Oracle_VM_VirtualBox_Extension_Pack"
                                               "steam-original"
                                               "steam-run"
                                               "steam-runtime"
                                             ];
}

