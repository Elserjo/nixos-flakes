{ cfg, pkgs, ... }:

let
  directorySymlink = pkgs.writeShellApplication {
    name = "hardlink-create";
    text = builtins.readFile ./hardlinks.sh;
    runtimeInputs = [ pkgs.coreutils pkgs.util-linux pkgs.flac ];
  };

in {
  home-manager.users.serg = {
    xdg.desktopEntries = {
      directorySymlink = {
        type = "Application";
        name = "directory-symlink";
        noDisplay = true;
        terminal = true;
        exec = "${directorySymlink}/bin/hardlink-create %F";
        mimeType = [ "audio/flac" ];
      };
    };
  };
}
