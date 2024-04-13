{
  xdg = {
    userDirs = {
      enable = true;
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "/data/Media/Music";
      videos = "/data/Media/Videos";
      pictures = "/data/Media/Pictures";
    };
    mimeApps = {
      enable = true;
      associations.added = {
        "inode/directory" = [
          "org.musicbrainz.Picard.desktop"
          "flacon.desktop"
          "musicLib_x5iii.desktop"
          "musicLib_se180.desktop"
        ];
      };
    };
  };
}
