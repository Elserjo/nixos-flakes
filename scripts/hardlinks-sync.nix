{ cfg, pkgs, ... }:

let
  directoryHardlink = pkgs.writeShellApplication {
    name = "hardlink-create";
    text = builtins.readFile ./hardlink-create.sh;
    runtimeInputs = [ pkgs.coreutils pkgs.util-linux pkgs.flac ];
  };

in {
  home-manager.users.serg = {
    xdg.desktopEntries = {
      directoryHardlink = {
        type = "Application";
        name = "directory-hardlink";
        noDisplay = true;
        terminal = true;
        exec = "${directoryHardlink}/bin/hardlink-create %F";
        mimeType = [ "audio/flac" ];
      };
    };
  };
}
