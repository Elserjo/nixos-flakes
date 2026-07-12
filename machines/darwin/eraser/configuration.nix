{ pkgs, ... }:

{
    system.stateVersion = 7;
    security.pam.services.sudo_local.touchIdAuth = true;

    nix.enable = false;

    environment.systemPackages = with pkgs; [
        hello
        rsync
        tmux
        htop
    ];
}
