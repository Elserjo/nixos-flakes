{ pkgs, ... }: {
  programs.chromium = {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "fddjpichkajmnkjhcmpbbjdmmcodnkej" # official rutracker plugin
      "edibdbjcniadpccecjdfdjjppcpchdlm" # i still don't care about cookies
    ];
  };
  home.packages = [ pkgs.profile-cleaner ];
}
