{ outputs, inputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports = [
    ./xdg.nix
    # ./programs/chromium.nix
    # ./programs/firefox.nix
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/htop.nix
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [{
      appId = "org.torproject.torbrowser-launcher";
      origin = "flathub";
    }];
  };

  nixpkgs = { overlays = [ outputs.overlays.modifications ]; };

  home.packages = with pkgs; [
    radeontop
    tor-browser-bundle-bin
    firefox
    duckstation
    pcsx2
    ppsspp-qt
    protonup-qt
    gimp
    geeqie
    mkvtoolnix
    flacon
    mediainfo-gui
    picard
    keepassxc
    cmus
    # modifications.tdesktop
    emacs-gtk
    freefilesync
    #If i need unstable: "unstable.nicotine"
    nicotine-plus
    libreoffice
    qpdfview
    qbittorrent-qt5
    kdenlive
    mpv
    upscayl
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
