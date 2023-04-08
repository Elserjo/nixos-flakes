{ lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "Oracle_VM_VirtualBox_Extension_Pack"
      "steam"
      "steam-original"
      "steam-run"
      "steam-runtime"
    ];
}

