# https://git.azahi.cc/nixfiles/tree/modules/nixos/firefox/default.nix
{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    arkenfox = { enable = true; };
    profiles.default-arkenfox = {
      arkenfox = {
        enable = true;
        "0000".enable = true;
        "0100" = {
          enable = true;
          "0102" = {
            enable = true;
            "browser.startup.page" = {
              enable = true;
              value = 3;
            };
          };
        };
        "0200".enable = true;
        "0300".enable = true;
        "0400".enable = true;
        "0600".enable = true;
        "0800" = {
          enable = true;
          "0801" = {
            enable = true;
            "keyword.enabled" = {
              enable = true;
              value = true;
            };
          };
        };
        #Passwords
        "0900".enable = true;
        #Disk avoidance
        "1000" = {
          enable = true;
          "1003" = {
            "browser.sessionstore.privacy_level" = {
              enable = true;
              value = 0;
            };
          };
        };
        #HTTPS (SSL/TLS/ OSCP / CERTS / HPKP)
        "1200".enable = true;
        #CONTAINERS
        "1700".enable = true;
        #PLUGINS/MEDIA/WEBRTC
        "2000".enable = true;
        #MISCELLANEOUS
        "2600".enable = true;
        #ETP (ENHANCED TRACKING PROTECTION)
        "2700".enable = true;
        #SHUTDOWN & SANITIZING
        "2800".enable = true;
      };
      settings = {
        #disable autoplay if you interacted with the site [FF78+]
        "media.autoplay.blocking_policy" = 2;
        "media.autoplay.default" = 5;
        "media.autoplay.enabled" = false;
      };
    };
  };
}
