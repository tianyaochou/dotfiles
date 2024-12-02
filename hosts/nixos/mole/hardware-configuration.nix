{ pkgs, lib, inputs, ... }:
let kernel = pkgs.callPackage "${inputs.rk3588}/pkgs/kernel/vendor.nix" {};
in {
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

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
    initrd.availableKernelModules = lib.mkForce [
      "nvme"
      "mmc_block"
      "hid"
      "dm_mod" # for LVM & LUKS
      "dm_crypt" # for LUKS
      "input_leds"
    ];

    kernelParams = [
      "rootwait"

      "earlycon"
      "consoleblank=0"
      "console=tty1"

      # docker optimizations
      "cgroup_enable=cpuset"
      "cgroup_memory=1"
      "cgroup_enable=memory"
      "swapaccount=1"
    ];

    supportedFilesystems = lib.mkForce [
      "vfat"
      "fat32"
      "extfat"
      "ext4"
      "btrfs"
    ];
  };

  hardware = {
    deviceTree = {
      # https://github.com/armbian/build/blob/f9d7117/config/boards/orangepi5-plus.wip#L10C51-L10C51
      name = "rockchip/rk3588-orangepi-5-plus.dtb";
      overlays = [
      ];
    };

    firmware = [
      (pkgs.callPackage "${inputs.rk3588}/pkgs/orangepi-firmware" {})
    ];

    enableRedistributableFirmware = lib.mkForce true;
  };
}
