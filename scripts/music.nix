{ config, pkgs, ... }:

let
  outputDir = "/data/Media/DAP/MusicLib";
  musicLib = pkgs.writeShellApplication {
    name = "music-lib";
    text = builtins.readFile ./music-lib.sh;
    runtimeInputs = [ pkgs.coreutils pkgs.util-linux pkgs.flac ];
  };
  # This script is echo escaped by ''
  # See also https://stackoverflow.com/questions/76862407/run-a-bash-command-in-gnome-terminal
  musicLibWrapper = pkgs.writeScriptBin "music-lib-wrapper" ''
    #!/usr/bin/env bash
    inputArgs=( "''${@}" )
    gnome-terminal -- ${pkgs.bash}/bin/bash -c '${musicLib}/bin/music-lib "''${@}"' -- "''${inputArgs[@]}"
  '';

in {
  home-manager.users.serg = {
    xdg.desktopEntries = {
      musicLib = {
        type = "Application";
        name = "add-to-music-lib";
        noDisplay = true;
        terminal = true;
        exec = "${musicLib}/bin/music-lib ${outputDir} %F";
        mimeType = [ "audio/flac" "audio/x-flac" ];
      };
    };
    # Use music-lib script in external programs
    home.packages = [ musicLibWrapper ];
  };
}
