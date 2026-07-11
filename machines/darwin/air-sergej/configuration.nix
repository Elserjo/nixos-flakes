{ pkgs, ... }:

{
    system.stateVersion = 4;

    nix.enable = false;

    environment.systemPackages = [
        pkgs.hello
    ];
}
