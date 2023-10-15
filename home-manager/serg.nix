{ outputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports =
    [ ./xdg.nix ./programs/firefox.nix ./programs/git.nix ];
  home.stateVersion = "22.11"; # Please read the comment before changing.

  nixpkgs = { overlays = [ outputs.overlays.modifications ]; };

  home.packages = with pkgs; [
    radeontop
    tor-browser-bundle-bin
    rpcs3
    pcsx2
    ppsspp-qt
    gimp
    geeqie
    mkvtoolnix
    flacon
    mediainfo-gui
    picard
    keepassxc
    quodlibet-full
    tdesktop-no-ads
    # modifications.tdesktop
    emacs-gtk
    freefilesync
    #If i need unstable: "unstable.nicotine"
    nicotine-plus
    libreoffice
    qpdfview
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
