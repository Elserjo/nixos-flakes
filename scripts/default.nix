{ cfg, pkgs, lib, ... }:

#https://github.com/NixOS/nixpkgs/blob/dade7540afee3578f7a4b98a39af42052cbc4a85/pkgs/build-support/trivial-builders.nix#L228-L253

let
  hello-script = pkgs.writeTextFile {
    name = "hello-script";
    executable = true;
    destination = "/bin/hello-script";
    text = builtins.readFile ./hello.sh;
  };

in { environment.systemPackages = with pkgs; [ hello-script ]; }
