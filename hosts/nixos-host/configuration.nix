# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../desktop/gnome.nix
    # ../../desktop/sway.nix
    ../../users/backuppc.nix
    ../../services/sound.nix
    ../../services/flatpak.nix
    ../../services/syncthing.nix
    ../../programs/virtualbox.nix
    ../../programs/steam.nix
    ../../scripts/garmin.nix
    ../../scripts/music.nix
  ];
  boot.loader.systemd-boot.enable = true;

  # change default linux kernel to xandmod
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.firewall = { allowedTCPPorts = [ 2234 46257 ]; };

  # programs.firejail = {
  #   enable = true;
  #   wrappedBinaries = {
  #     telegram = {
  #       executable =
  #         "${pkgs.lib.getBin pkgs.tdesktop-no-ads}/bin/telegram-desktop";
  #       profile = "${pkgs.firejail}/etc/firejail/telegram-desktop.profile";
  #     };
  #   };
  # };
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LANGUAGE = "ru_RU:en_US:en";
    LC_CTYPE = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
    LC_COLLATE = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_MESSAGES = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
  };
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    keyMap = "ruwin_alt_sh-UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.serg = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "audio" "video" "adbusers" ]; # Enable ‘sudo’ for the user.

    packages = with pkgs;
      [
        nixfmt # Nix code formatter
      ];
  };

  #Import main home-manager config with my user
  home-manager.users.serg = {
    imports = [ ../../home-manager/serg.nix ];
    home.stateVersion = "24.05";
  };

  programs.adb.enable = true;

  fonts.packages = with pkgs; [
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
  ];

  fonts.enableDefaultPackages = true;
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Liberation Sans" ];
      monospace = [ "Liberation Mono" ];
    };
  };

  environment.systemPackages = with pkgs; [ vim htop nix-tree p7zip ];

  #By default NixOS cpu governor is powersave
  #powerManagement.cpuFreqGovernor = "performance";
  programs.vim.defaultEditor = true;

  services.journald.extraConfig = ''
    Storage=persistent
    SystemMaxUse=350M
  '';

  hardware.bluetooth.enable = true;

  # List services that you want to enable:
  # Fstrim should be disable with luks
  # services.fstrim.enable = true;

  nix = {
    # Enable weekly garbage collect
    gc = {
      automatic = true;
      options = ''
        --delete-older-than 21d
      '';
      dates = "weekly";
    };
    settings = {
      max-jobs = 1;
      cores = 4;
      keep-going = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
