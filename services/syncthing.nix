{ cfg, ... }:

{
  services.syncthing = {
    enable = true;
    user = "serg";
  };
}
