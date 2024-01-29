{ config, pkgs, ... }:

let
  futura_outputDir = "/data/Media/DAP/MusicLib/SE180";
  fiio_outputDir = "/data/Media/DAP/MusicLib/X5III";

  musicLib = pkgs.writeShellApplication {
    name = "music-lib";
    text = builtins.readFile ./music-lib.sh;
    runtimeInputs = [ pkgs.coreutils pkgs.util-linux pkgs.flac ];
  };

  resizeImg = pkgs.writeShellApplication {
    name = "resize-img";
    text = builtins.readFile ./resize-img.sh;
    runtimeInputs = [ pkgs.coreutils pkgs.graphicsmagick ];
  };

  # This script is echo escaped by ''
  # See also https://stackoverflow.com/questions/76862407/run-a-bash-command-in-gnome-terminal
  # First arg is always output path for musicLib
  musicLibWrapper = pkgs.writeScriptBin "music-lib-wrapper" ''
    #!/usr/bin/env bash
    dirName=( "''${@}" )
    gnome-terminal -- ${pkgs.bash}/bin/bash -c '${musicLib}/bin/music-lib "''${@}"' -- "''${dirName[@]}"
  '';

in {
  home-manager.users.serg = {
    xdg.desktopEntries = {
      musicLib_se180 = {
        type = "Application";
        name = "add-to-music-lib-se180";
        noDisplay = true;
        terminal = true;
        exec = "${musicLib}/bin/music-lib ${futura_outputDir} %F";
        mimeType = [ "audio/flac" "audio/x-flac" ];
      };
      musicLib_x5iii = {
        type = "Application";
        name = "add-to-music-lib-x5iii";
        noDisplay = true;
        terminal = true;
        exec = "${musicLib}/bin/music-lib ${fiio_outputDir} %F";
        mimeType = [ "audio/flac" "audio/x-flac" ];
      };
      resizeImg = {
        type = "Application";
        name = "resize-image";
        terminal = false;
        exec = "${resizeImg}/bin/resize-img %F";
        mimeType = [ "image/jpg" "image/x-jpg"];
      };
    };
    # Use music-lib script in external programs
    home.packages = [ musicLibWrapper ];
  };
}
