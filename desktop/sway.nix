{ config, lib, pkgs, ... }:

{
  security.polkit.enable = true;

  services.dbus.enable = true;
  services.gvfs.enable = true;
  # services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs.sway.package = null;
  programs.sway.enable = true;

  fonts.packages = with pkgs; [
    cantarell-fonts
    roboto
    noto-fonts-color-emoji
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    gnome3.adwaita-icon-theme
    gnome.nautilus
  ];
  #Sway settings for my local user
  home-manager.users.serg = {
    #I will use these packages only with sway
    home.packages = with pkgs; [ cmus transmission-gtk imv ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures = { gtk = true; };
      config = {
        bars = [{
          command = "${pkgs.waybar}/bin/waybar";
          # Has no effect for swaybar
          # fonts.size = 15.0;
        }];
        assigns = {
          "1" = [{ app_id = "firefox"; }];
          "2" = [{ app_id = "org.telegram.desktop"; }];
        };
        startup = [
          { command = "firefox"; }
          { command = "telegram-desktop"; }
          { command = "${pkgs.swaykbdd}/bin/swaykbdd"; }
          { command = "${pkgs.udiskie}/bin/udiskie &"; }
          {
            command =
              "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          }
        ];
        focus.followMouse = "no";
        modifier = "Mod4";
        menu = "${pkgs.wofi}/bin/wofi --show drun";
        output = { "DP-3" = { mode = "2560x1440@120Hz"; }; };
      };
      # I am too lazy for reading some options
      # See good example of swaylock and swayidle
      # https://www.reddit.com/r/swaywm/comments/afu6cd/how_to_turn_off_the_screen_after_locking_with/
      extraConfig = ''
        output * bg $HOME/Wallpapers/wallhaven-w85r9q.jpg fill
        input "type:keyboard" {
            xkb_layout us,ru
            xkb_options grp:win_space_toggle
        }

        exec ${pkgs.swayidle}/bin/swayidle -w \
            timeout 1200 '${pkgs.swaylock}/bin/swaylock -f -c 353535' \
            timeout 1210 'swaymsg "output * dpms off"' \
            timeout 15 'if pgrep -x swaylock; then swaymsg "output * dpms off"; fi' \
            resume 'swaymsg "output * dpms on"' 

        bindsym --locked XF86AudioPrev exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous
        bindsym --locked XF86AudioPlay exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause
        bindsym --locked XF86AudioStop exec --no-startup-id ${pkgs.playerctl}/bin/playerctl stop
        bindsym --locked XF86AudioNext exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next

        bindsym --locked XF86AudioMute exec --no-startup-id ${pkgs.pulseaudio}/bin//pactl set-sink-mute 0 toggle
        bindsym --locked XF86AudioLowerVolume exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%
        bindsym --locked XF86AudioRaiseVolume exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%
      '';
      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=sway
        export XDG_CURRENT_DESKTOP=sway
        export MOZ_ENABLE_WAYLAND=1
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QT_QPA_PLATFORMTHEME=gtk3
      '';
    };

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 35;
          modules-left = [ "sway/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [ "wireplumber" "sway/language" ];

          "sway/workspaces" = {
            "disable-scroll" = true;
            "all-outputs" = true;
          };

          "sway/language" = {
            format = "{flag} {shortDescription}";
            tooltip = false;
          };

          "clock" = {
            interval = 60;
            format = "{:%a, %d/%m %H:%M}";
          };

          "wireplumber" = {
            format = "{volume}% {icon}";
            format-muted = "";
            format-icons = [ "" "" "" ];
          };
        };
      };
    };
    programs.waybar.style = ''
      * {
        border: none;
        border-radius: 0;
        padding: 0;
        font-family: "Cantarell", "Roboto", sans-serif;
        font-size: 14px;
      }

      window#waybar {
        background: #292828;
      }

      #workspaces button {
        margin-right: 8px;
        color: #ffffff;
        font-weight: bold;
      }

      #workspaces button:hover, #workspaces button:active {
        background-color: #292828;
        color: #383737;
      }

      #workspaces button.focused {
        background-color: #383737;
      }

      #language,
      #clock,
      #wireplumber {
        margin-right: 10px;		
        font-weight: bold;
        background-color: #292828;
        color: #ffffff;
        padding: 3px;
      }
    '';
    # Foot settings
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "SourceCodePro:size=13";
          dpi-aware = "yes";
          selection-target = "clipboard";
        };
        colors = { alpha = 0.9; };
      };
    };
    # Fix cursor for some apps
    home = {
      pointerCursor = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
        size = 24;
        x11 = {
          enable = true;
          defaultCursor = "Adwaita";
        };
      };
      sessionVariables = { TERMINAL = "foot"; };
    };
    xdg.mimeApps.defaultApplications = {
      "image/jpeg" = "imv-folder.desktop";
      "image/png" = "imv-folder.desktop";
      "image/gif" = "imv-folder.desktop";
    };
  };
}
