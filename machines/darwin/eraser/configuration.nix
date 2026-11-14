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
            upgrade = true;
            cleanup = "zap";
        };
        caskArgs.require_sha = true;
        onActivation.extraEnv = {
            HOMEBREW_NO_ANALYTICS = "1";
            HOMEBREW_NO_INSECURE_REDIRECT = "1";
        };
        casks = [
            "firefox"
            "keepassxc"
            "syncthing-app"
            "openvpn-connect"
            "phoenix-slides"
            "iina"
            "thunderbird"
            "gimp"
            "utm"
            "tor-browser"
            "transmission"
        ];
    };

    environment.systemPackages = with pkgs; [
        rsync
        htop
        yt-dlp
        ffmpeg
        flac2mp3
        sshpass
    ];
}
