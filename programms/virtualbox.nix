{ config, lib, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;

  virtualisation.virtualbox.host.enableExtensionPack = true;

  users.extraGroups.vboxusers.members = [ "serg" ];

  modules.unfree.nix.common.allowedUnfreePackages =
    [ "Oracle_VM_VirtualBox_Extension_Pack" ];
}
