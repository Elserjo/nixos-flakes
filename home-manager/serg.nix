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
    ./programs/vim.nix
    ./programs/direnv.nix
    ./programs/htop.nix
  ];

  nixpkgs = { overlays = [ outputs.overlays.modifications ]; };

  home.packages = with pkgs; [
    radeontop
    firefox
    gimp
    geeqie
    mkvtoolnix
    flacon
    mediainfo-gui
    picard
    keepassxc
    cmus
    strawberry-qt6
    # modifications.tdesktop
    emacs-gtk
    freefilesync
    #If i need unstable: "unstable.nicotine"
    nicotine-plus
    libreoffice
    qpdfview
    qbittorrent
    vlc
    telegram-desktop
    upscayl
    tor-browser
    nicotine-plus
    wireplumber
    nekoray
    mosh
    p7zip
    pcsx2
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
