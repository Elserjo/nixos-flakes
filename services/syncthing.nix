{ cfg, ... }:

{
  services.syncthing = {
    enable = true;
    user = "serg";
    configDir = "/home/serg/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "synology" = {
        id = "IQBNIEA-MZQZGBU-YM2KVJE-B6D3QAV-UIXVCSU-OD5MIRY-E3UMC25-4ROKIAF";
      };
    };
    folders."syncthing" = {
      path = "~/Media/syncthing";
      devices = [ "synology" ];
      versioning = {
        type = "simple";
        params = {
          keep = "5";
          cleanoutDays = "30";
          cleanInterval = "3600";
        };
      };
    };
  };
}
