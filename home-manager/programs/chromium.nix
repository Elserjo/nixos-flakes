{ pkgs, ... }: {
  programs.chromium = {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "fddjpichkajmnkjhcmpbbjdmmcodnkej" # official rutracker plugin
    ];
  };
  home.packages = [ pkgs.profile-cleaner ];
}
