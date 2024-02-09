{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

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
      epiphany # web browser
      geary # email reader
      #evince # document viewer
      gnome-characters
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
      gnome-console
      gnome-text-editor
      loupe # new gnome default image viewer
      snapshot # gnome camera app
    ]);
    systemPackages = (with pkgs; [ gedit ])
      ++ (with pkgs.gnome; [ gnome-terminal ]);
    sessionVariables = {
      # See bug https://bugs.launchpad.net/ubuntu/+source/gnome-settings-daemon/+bug/1971434
     MUTTER_DEBUG_ENABLE_ATOMIC_KMS = "0";
    };
  };
}
