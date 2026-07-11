{ pkgs, ... }:

{
    system.stateVersion = 7;

    nix.enable = false;

    environment.systemPackages = with pkgs; [
        hello
        rsync
        gcc
        tmux
        htop
    ];
}
