{ cfg, pkgs, ... }:

{
    my-name = "hello-script";
    my-script = (pkgs.writeScriptBin my-name (builtins.readfile ./hello.sh));
} 
