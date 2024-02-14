{ outputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports = [
    ./xdg.nix
    ./programs/chromium.nix
    ./programs/git.nix
    ./programs/direnv.nix
  ];

  nixpkgs = { overlays = [ outputs.overlays.modifications ]; };

  home.packages = with pkgs; [
    radeontop
    tor-browser-bundle-bin
    duckstation
    pcsx2
    ppsspp-qt
    gimp
    geeqie
    mkvtoolnix
    flacon-with-ape
    mediainfo-gui
    picard
    keepassxc
    quodlibet-full
    cmus
    tdesktop-no-ads
    # modifications.tdesktop
    emacs-gtk
    freefilesync
    #If i need unstable: "unstable.nicotine"
    nicotine-plus
    libreoffice
    qpdfview
    qbittorrent-qt5
    kdenlive
    vlc
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
