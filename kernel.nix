{ pkgs, config, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
}
