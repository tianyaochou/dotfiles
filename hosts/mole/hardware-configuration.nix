{ self, ... }:
{ pkgs, lib, packages, inputs, ... }:
let kernel = pkgs.buildLinux {
  modDirVersion = "6.13.0";
  version = "6.13.0";
  src = fetchGit {
    url = "file:///home/tianyaochou/Projects/linux-rockchip";
    rev = "188b245f91764c7c5246517a4422767db11d8bf9";
  };
};
  mainline = pkgs.linuxKernel.kernels.linux_testing;
  selectedKernel = mainline;
in {
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  boot = {
    kernelPackages = pkgs.linuxPackagesFor selectedKernel;
    extraModulePackages = [ packages.snps-hdmirx ];
    loader.grub = {
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
      enable = true;
      configurationLimit = 2;
      extraFiles = {
        "dtb/base/rk3588-orangepi-5-plus.dtb" = ./rk3588-orangepi-5-plus.dtb;#"${selectedKernel}/dtbs/rockchip/rk3588-orangepi-5-plus.dtb";
      };
    };
    initrd.availableKernelModules = lib.mkForce [
      "nvme"
      "mmc_block"
      "hid"
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
      name = "rockchip/rk3588-orangepi-5-plus.dtb";
      overlays = [
      ];
    };

    firmware = [
      (pkgs.callPackage "${inputs.rk3588}/pkgs/orangepi-firmware" {})
      (pkgs.callPackage "${inputs.rk3588}/pkgs/mali-firmware" {})
    ];

    enableRedistributableFirmware = lib.mkForce true;
  };
}
