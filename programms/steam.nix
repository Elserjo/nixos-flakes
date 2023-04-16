{ config, pkgs, lib, ... }:

{
  programs.steam = { enable = true; };

  hardware.steam-hardware.enable = true;
  modules.unfree.nix.allowedUnfreePackages = [
    "steam"
    "steam-original"
    "steam-run"
    "steam-runtime"
  ];
}
