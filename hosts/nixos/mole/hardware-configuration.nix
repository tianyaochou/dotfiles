{ config, lib, pkgs, inputs, ... }: 
let kernel = pkgs.callPackage "${inputs.rk3588}/pkgs/kernel/vendor.nix" {};#pkgs.linuxKernel.kernels.linux_6_11;
in {
  boot = {
    kernelPackages = pkgs.linuxPackagesFor kernel;
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 2;
      extraFiles = {
        "dtb/base/rk3588-orangepi-5-plus.dtb" = "${kernel}/dtbs/rockchip/rk3588-orangepi-5-plus.dtb";
      };
    };
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [
      "earlycon"
      "console=ttyS2,1500000" # serial port
      "console=tty1" # HDMI
    ];
  };

  hardware = {
    deviceTree = {
      name = "rockchip/rk3588-orangepi-5-plus.dtb";
      overlays = [];
    };
    enableRedistributableFirmware = true;
    firmware = [(pkgs.callPackage "${inputs.rk3588}/pkgs/orangepi-firmware" {})];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/51f3bb58-7085-478e-9c89-230a1fc8f9bc";
    fsType = "btrfs";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AD8E-21CA";
    fsType = "vfat";
  };
}
