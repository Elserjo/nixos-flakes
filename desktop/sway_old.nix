{ config, pkgs, lib, ... }:

let
  sway-run = pkgs.writeTextFile {
    name = "sway-run";
    destination = "/bin/sway-run";
    executable = true;

    text = ''
      dbus-run-session -- sway $@
    '';
  };

  swayConfig = pkgs.writeText "greetd-sway-config" ''
    # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
    exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -c sway; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
  imports = [
    ./overlays.nix
  ];

  environment.systemPackages = with pkgs; [
    sway-run
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "dbus-run-session -- ${pkgs.sway}/bin/sway --config ${swayConfig}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    sway-run
  '';

  # Set default applications for sway desktop
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "inode/directory" = "nemo.desktop";
    "application/pdf" = "org.pwmt.zathura.desktop";
    "image/jpeg" = "imv-folder.desktop";
    "image/png" = "imv-folder.desktop";
    "image/gif" = "imv-folder.desktop";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
      export MOZ_ENABLE_WAYLAND=1

      export QT_QPA_PLATFORM=wayland
      export QT_QPA_PLATFORMTHEME=gnome
    '';
    extraPackages = with pkgs; [
      waybar
      wofi
      greetd.gtkgreet
      gnome.adwaita-icon-theme
      qgnomeplatform
      glib
      grim
      xdg-user-dirs
      xdg-utils
      udiskie
      pavucontrol
      swaylock
      swayidle
      libnotify
      mako
      alacritty
      swaykbdd
      playerctl
    ];
  };
}
