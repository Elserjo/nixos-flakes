{ config, lib, pkgs, ... }:

{
  security.polkit.enable = true;

  #Sway settings for my local user
  home-manager.users.serg = {
    wayland.windowManager.sway.enable = true;
  };
}
