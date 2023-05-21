# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./kernel.nix
    ./desktop/gnome.nix
    ./services/sound.nix
    ./services/syncthing.nix
    ./programs
    ./scripts
  ];

  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot.enable = true;

  # update intel microcode.
  hardware.cpu.intel.updateMicrocode = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  #Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LANGUAGE = "ru_RU:en_US:en";
    LC_CTYPE = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
    LC_COLLATE = "C";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_MESSAGES = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_ADDRES = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_INDETIFICATION = "ru_RU.UTF-8";
  };
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    keyMap = "ruwin_alt_sh-UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.serg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ]; # Enable ‘sudo’ for the user.

    packages = with pkgs; [
      emacs-gtk
      nixfmt # Nix code formatter
    ];
  };

  fonts.fonts = with pkgs; [ terminus_font noto-fonts ];

  fonts.enableDefaultFonts = true;
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Liberation Sans" ];
      monospace = [ "Liberation Mono" ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    htop
    lm_sensors
    nix-tree
    ventoy-bin
    p7zip
    ntfs3g
  ];

  #By default NixOS cpu governor is powersave
  powerManagement.cpuFreqGovernor = "performance";

  programs.vim.defaultEditor = true;

  services.journald.extraConfig = ''
    Storage=persistent
    SystemMaxUse=50M
  '';

  hardware.bluetooth.enable = true;

  # List services that you want to enable:
  services.fstrim.enable = true;

  # Enable weekly garbage collect
  nix.gc = {
    automatic = true;
    options = ''
      --delete-old
    '';
    dates = "weekly";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
