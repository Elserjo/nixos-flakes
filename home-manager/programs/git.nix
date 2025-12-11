{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Serg";
      user.email = "reznov90210@gmail.com";
    };
  };
}
