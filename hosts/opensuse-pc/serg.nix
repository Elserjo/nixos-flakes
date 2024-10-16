{ outputs, inputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serg";
  home.homeDirectory = "/home/serg";

  imports = [
    ../../home-manager/xdg.nix
    # ./programs/chromium.nix
    # ./programs/firefox.nix
    ../../home-manager/programs/git.nix
    ../../home-manager/programs/vim.nix
    ../../home-manager/programs/direnv.nix
    ../../home-manager/programs/htop.nix
    ../../scripts/music.nix
  ];

  nixpkgs = { overlays = [ outputs.overlays.modifications ]; };

  home.packages = with pkgs; [
    radeontop
    # modifications.tdesktop
    #If i need unstable: "unstable.nicotine"
    mosh
    ventoy-full
    nixfmt
    emacs-gtk
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
