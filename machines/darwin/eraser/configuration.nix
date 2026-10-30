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
        casks = [
            "firefox"
            "keepassxc"
            "syncthing-app"
            "telegram"
            "openvpn-connect"
            "libreoffice"
            "libreoffice-language-pack"
            "phoenix-slides"
            "iina"
            "thunderbird"
            "gimp"
            "utm"
            "tor-browser"
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
