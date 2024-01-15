# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "nct6775" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."data" = {
    device = "/dev/disk/by-uuid/814a3c86-9694-4fcd-83ab-e58fb67e6f76";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/80971aac-983f-493a-96b9-351ee0602111";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/81c6ea36-c820-455d-a9fb-fcaac4a41e24";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BCE7-61C1";
    fsType = "vfat";
  };

  fileSystems."/data/Work" = {
    device = "/dev/disk/by-uuid/6eb1533c-30aa-488d-8ffc-b8d26b30e64d";
    fsType = "ext4";
  };

  fileSystems."/data/Media" = {
    device = "/dev/disk/by-uuid/a70ba49b-ac12-4f15-9b43-d4b00a6607f3";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display

  #This option does not have any effect
  #hardware.video.hidpi.enable = lib.mkDefault true;
}
