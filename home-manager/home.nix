{ outputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports = [ ./programs ];
  home.stateVersion = "22.11"; # Please read the comment before changing.

  nixpkgs = { overlays = [ outputs.overlays.unstable-packages ]; };

  home.packages = with pkgs; [
    radeontop
    tor-browser-bundle-bin
    rpcs3
    pcsx2
    qbittorrent
    gimp
    geeqie
    mkvtoolnix
    flacon
    mediainfo-gui
    picard
    keepassxc
    quodlibet-full
    tdesktop
    emacs-gtk
    freefilesync
    #If i need unstable: "unstable.nicotine"
    nicotine-plus
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
