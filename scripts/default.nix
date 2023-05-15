{ cfg, pkgs, ... }:

#https://github.com/NixOS/nixpkgs/blob/dade7540afee3578f7a4b98a39af42052cbc4a85/pkgs/build-support/trivial-builders.nix#L228-L253

let
  garminService = "garmin";
  garmin-backup = pkgs.writeShellApplication {
    name = "garmin-backup";
    text = builtins.readFile ./garmin-backup.sh;
    runtimeInputs = [ pkgs.libnotify pkgs.rsync pkgs.coreutils pkgs.util-linux ];
  };

in {
  systemd.user.services."${garminService}" = {
    description = "Backup garmin activities when Garmin 830 is connected";
    requires = [ "run-media-serg-GARMIN.mount" ];
    after = [ "run-media-serg-GARMIN.mount" ];
    wantedBy = [ "run-media-serg-GARMIN.mount" ];
    serviceConfig = {
      ExecStart = "${garmin-backup}/bin/garmin-backup";
      Type = "forking";
    };
  };
  services.udev.extraRules = ''
        ACTION=="change", SUBSYSTEM=="block",
        ENV{ID_VENDOR_ID}=="091e", ENV{ID_MODEL_ID}=="2c32", ENV{ID_SERIAL}=="Garmin_GARMIN_Flash-0:0",
    ENV{SYSTEMD_WANTS}=="${garminService}.service"
  '';
}
