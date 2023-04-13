#https://git.azahi.cc/nixfiles/tree/modules/nixos/firefox/default.nix
{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    arkenfox = {
      enable = true;
    };
    profiles.default-arkenfox.arkenfox = {
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
    };
  };
}
      
