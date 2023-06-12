{ cfg, pkgs, ... }:

let
  musicLib = pkgs.writeShellApplication {
    name = "hardlink-create";
    text = builtins.readFile ./music-lib.sh;
    runtimeInputs = [ pkgs.coreutils pkgs.util-linux pkgs.flac ];
  };

in {
  home-manager.users.serg = {
    xdg.desktopEntries = {
      musicLib = {
        type = "Application";
        name = "music-lib";
        noDisplay = true;
        terminal = true;
        exec = "${musicLib}/bin/music-lib %F";
        mimeType = [ "audio/flac" ];
      };
    };
  };
}
