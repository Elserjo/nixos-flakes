{ pkgs, inputs,  ... }:

{
    system.stateVersion = 7;
    system.primaryUser = "serg";
    security.pam.services.sudo_local.touchIdAuth = true;

    nix.enable = false;

    environment.variables = {
        EDITOR = "vim";
    };

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
