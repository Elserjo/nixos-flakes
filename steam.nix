{ config, pkgs, lib, ... }:

{
    programs.steam = {
        enable = true;
    };

    hardware.steam-hardware.enable = true;
}
