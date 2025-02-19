{
  config,
  lib,
  pkgs,
  ...
}: let
  ids = ["1002:73df" "1002:ab28"];
in {
  boot.kernelParams = ["intel_iommu=on" ("vfio-pci.ids=" + lib.concatStringsSep "," ids)];
  boot.initrd.kernelModules = ["vfio_pci" "vfio" "vfio_iommu_type1"];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [
        (pkgs.OVMFFull.override {
          secureBoot = true;
          tpmSupport = true;
        })
      ];
      vhostUserPackages = [pkgs.virtiofsd];
    };
  };

  environment.etc = {
    "ovmf/edk2-x86_64-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-code.fd";
    };

    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;
  environment.systemPackages = with pkgs; [virt-manager win-virtio spice win-spice];
}
