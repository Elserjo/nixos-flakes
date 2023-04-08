{ pkgs, config, ... }:

{
    boot.kernelPackages = pkgs.linuxPackages_lqx;
}
