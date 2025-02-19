{
  pkgs,
  lib,
  kernel ? pkgs.linuxKernel.kernels.linux_testing,
}:
pkgs.stdenv.mkDerivation {
  pname = "snps-hdmirx-kernel-module";
  inherit (kernel) src version postPatch nativeBuildInputs;

  kernel_dev = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  modulePath = "drivers/media/platform/synopsys/hdmirx";

  patches = [
    ../hosts/mole/hdmirx.patch
  ];

  configurePhase = ''
  '';

  buildPhase = ''
    BUILT_KERNEL=$kernel_dev/lib/modules/$kernelVersion/build

    cp $BUILT_KERNEL/Module.symvers .
    cat $BUILT_KERNEL/.config       > .config
    cp $kernel_dev/vmlinux          .
    echo "CONFIG_VIDEO_SYNOPSYS_HDMIRX=m" >> .config
    echo "CONFIG_VIDEO_SYNOPSYS_HDMIRX_LOAD_DEFAULT_EDID=y" >> .config

    make "-j$NIX_BUILD_CORES" modules_prepare
    make "-j$NIX_BUILD_CORES" M=$modulePath #modules
  '';

  installPhase = ''
    mkdir $out
    make \
      INSTALL_MOD_PATH=$out \
      XZ="xz -T$NIX_BUILD_CORES" \
      M="$modulePath" \
      modules_install
  '';

  meta = {
    description = "Synopsys HDMIRX kernel module";
    license = lib.licenses.gpl3;
  };
}
