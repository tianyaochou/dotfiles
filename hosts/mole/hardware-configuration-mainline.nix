{self, ...}: {
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  kernel = pkgs.linuxKernel.kernels.linux_6_11;
in {
  boot = {
    kernelPackages = pkgs.linuxPackagesFor kernel;
    loader.grub = {
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
      enable = true;
      configurationLimit = 2;
      extraFiles = {
        "dtb/base/rk3588-orangepi-5-plus.dtb" = "${kernel}/dtbs/rockchip/rk3588-orangepi-5-plus.dtb";
      };
    };
    kernelParams = [
      "earlycon"
      "console=tty1" # HDMI
    ];
  };

  hardware = {
    deviceTree = {
      name = "rockchip/rk3588-orangepi-5-plus.dtb";
      overlays = [];
    };
  };
}
