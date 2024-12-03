{ lib, ... }:
{
  boot.initrd.availableKernelModules = [ "xen-blkfront" "xen-kbdfront" ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/xvda";
  };

  networking.useDHCP = lib.mkDefault true;
}
