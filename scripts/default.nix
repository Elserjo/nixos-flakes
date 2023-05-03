{ cfg, pkgs, ... }:

#https://github.com/NixOS/nixpkgs/blob/dade7540afee3578f7a4b98a39af42052cbc4a85/pkgs/build-support/trivial-builders.nix#L228-L253

let
  garmin-backup = pkgs.writeShellApplication {
    name = "garmin-backup";
    text = builtins.readFile ./garmin-backup.sh;
    runtimeInputs = [ pkgs.libnotify pkgs.rsync ];
  };

in { environment.systemPackages = [ garmin-backup ]; }
