{ pkgs, inputs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackagesFor pkgs.linuxKernel.kernels.linux_6_7;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  hardware = {
    deviceTree = {
      name = "rockchip/rk3588-orangepi-5-plus.dtb";
      overlays = [];
    };
    firmware = [];
  };

  fileSystems."/" = {
    device = "/disk/by-uuid/51f3bb58-7085-478e-9c89-230a1fc8f9bc";
    fsType = "btrfs";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AD8E-21CA";
    fsType = "vfat";
  };
}
