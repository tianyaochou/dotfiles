{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [ "intel_iommu=on" ];
  boot.initrd.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager win-virtio spice win-spice ];
}
