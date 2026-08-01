{ pkgs, inputs,  ... }:

{
    system.stateVersion = 7;
    system.primaryUser = "serg";
    security.pam.services.sudo_local.touchIdAuth = true;

    nix.enable = false;

    homebrew = {
        enable = true;
        onActivation = {
            autoUpdate = true;
            cleanup = "zap";
        };
        casks = [
            "firefox"
            "keepassxc"
            "syncthing-app"
            "telegram"
            "openvpn-connect"
        ];
    };

    environment.systemPackages = with pkgs; [
        hello
        rsync
        tmux
        htop
        yt-dlp
        ffmpeg
    ];
}
