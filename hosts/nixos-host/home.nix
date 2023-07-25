{ outputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports = [
    ../../home-manager/xdg.nix
    ../../home-manager/programs/firefox.nix
    ../../home-manager/programs/git.nix
  ];
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
