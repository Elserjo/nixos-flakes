{
  imports = [ ./home.nix ];

  xdg = {
    userDirs = {
      enable = true;
      documents = "$HOME/Documents";
      music = "$HOME/Media/Music";
      videos = "$HOME/Media/Videos";
      pictures = "$HOME/Media/Pictures";
    };
  };
}
