{ cfg, pkgs, ... }:

#https://github.com/NixOS/nixpkgs/blob/dade7540afee3578f7a4b98a39af42052cbc4a85/pkgs/build-support/trivial-builders.nix#L228-L253

let
  garminService = "garmin";
  garmin-backup = pkgs.writeShellApplication {
    name = "garmin-backup";
    text = builtins.readFile ./garmin-backup.sh;
    runtimeInputs =
      [ pkgs.libnotify pkgs.rsync pkgs.coreutils pkgs.util-linux ];
  };

in
{
  systemd.user.services."${garminService}" = {
    description = "Backup garmin activities when Garmin 830 is connected";
    requires = [ "media-GARMIN.mount" ];
    after = [ "media-GARMIN.mount" ];
    wantedBy = [ "media-GARMIN.mount" ];
    serviceConfig = {
      ExecStart = "${garmin-backup}/bin/garmin-backup";
      Type = "forking";
    };
  };
  systemd.tmpfiles.rules = [ "D /media 0755 root root 0 -" ];
  #Prevent automount Garmin 830 to /run/$USER/...
  #use /media instead
  services.udev.extraRules = ''
        ACTION=="change", SUBSYSTEM=="block", ENV{ID_VENDOR_ID}=="091e", ENV{ID_MODEL_ID}=="2c32",
    ENV{ID_SERIAL}=="Garmin_GARMIN_Flash-0:0", ENV{UDISKS_FILESYSTEM_SHARED}="1"
  '';
}
