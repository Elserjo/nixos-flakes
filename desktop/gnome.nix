{ config, pkgs, ... }:

{
  # See https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services = {
    displayManager.defaultSession = "gnome";
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.debug = true;
      displayManager.gdm.wayland = true;
      displayManager.gdm.settings = {
        daemon = {
          AutomaticLoginEnable = true;
          AutomaticLogin = "serg";
        };
      };
    };
  };
  services.gnome = {
    gnome-online-accounts.enable = false;
    gnome-remote-desktop.enable = false;
    gnome-user-share.enable = false;
    rygel.enable = false;
    gnome-browser-connector.enable = false;
    gnome-initial-setup.enable = false;
  };

  environment = {
    gnome.excludePackages = (with pkgs.gnome; [
      cheese
      gnome-logs
      gnome-music
      gnome-maps
      gnome-contacts
      gnome-system-monitor
      gnome-disk-utility
      gnome-calendar
      gnome-software
      epiphany # web browser
      geary # email reader
      #evince # document viewer
      # gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      evince
      simple-scan
      eog
      baobab
    ]) ++ (with pkgs; [
      gnome-tour
      gnome-photos
      gnome-connections
      gnome-usage
      gnome-secrets
      gnome-text-editor
      loupe # new gnome default image viewer
      snapshot # gnome camera app
    ]);
    systemPackages =
      (with pkgs; [ gedit qadwaitadecorations-qt6 ]);
    # ++ (with pkgs.gnome; [ gnome-terminal ]);
    sessionVariables = {
      # See bug https://bugs.launchpad.net/ubuntu/+source/gnome-settings-daemon/+bug/1971434
      # MUTTER_DEBUG_ENABLE_ATOMIC_KMS = "0";
      QT_WAYLAND_DECORATION = "adwaita";
    };
  };
  #Need for qadwaitatheme
  qt.enable = true;
}
