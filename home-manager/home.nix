{ outputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports = [ ./programs ];
  home.stateVersion = "22.11"; # Please read the comment before changing.

  nixpkgs = { overlays = [ outputs.overlays.unstable-packages ]; };

  modules.unfree.nix.allowedUnfreePackages =
    [ "Oracle_VM_VirtualBox_Extension_Pack" ];

  home.packages = with pkgs; [
    hello
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
    unstable.nicotine-plus
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
