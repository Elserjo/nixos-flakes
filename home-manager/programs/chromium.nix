{ pkgs, ... }: {
  programs.chromium = {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "fddjpichkajmnkjhcmpbbjdmmcodnkej" # official rutracker plugin
    ];
  };
}
