{ config, lib, pkgs, ... }:
let passthruIDs = [
  "10de:21c4"
  "10de:1aeb" 
  #"144d:a808"
  ]; in
{
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"
    ];

    kernelParams = [
      # enable IOMMU
      "intel_iommu=on"
    ] ++
      # isolate the GPU
    [("vfio-pci.ids=" + lib.concatStringsSep "," passthruIDs)];
  };
  hardware.opengl.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };
  environment.systemPackages = with pkgs;
    [ virt-manager win-virtio
      spice win-spice ];
  services.cockpit.enable = true;
}
