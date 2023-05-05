{ cfg, pkgs, ... }:

#https://github.com/NixOS/nixpkgs/blob/dade7540afee3578f7a4b98a39af42052cbc4a85/pkgs/build-support/trivial-builders.nix#L228-L253

{
  services.udev.extraRules = let
    garmin-backup = pkgs.writeShellApplication {
      name = "garmin-backup";
      text = builtins.readFile ./garmin-backup.sh;
      runtimeInputs = [ pkgs.libnotify pkgs.rsync pkgs.coreutils ];
    };
  in ''
        ACTION=="change", SUBSYSTEM=="block",
        ENV{ID_VENDOR_ID}=="091e", ENV{ID_MODEL_ID}=="2c32", ENV{ID_SERIAL}=="Garmin_GARMIN_Flash-0:0",
    RUN+="${garmin-backup}/bin/garmin-backup"
  '';
}
