{ lib, stdenv, fetchurl, substituteAll, autoreconfHook, pkg-config, libusb1, hwdata, python3 }:

stdenv.mkDerivation rec {
  pname = "usbutils";
  version = "017";

  src = fetchurl {
    url = "mirror://kernel/linux/utils/usb/usbutils/usbutils-${version}.tar.xz";
    hash = "sha256-pqJf/c+RA+ONekRzKsoXBz9OYCuS5K5VYlIxqCcC4Fs=";
  };

  # patches = [
  #   (substituteAll {
  #     src = ./fix-paths.patch;
  #     inherit hwdata;
  #   })
  # ];

  patches = [
    (fetchurl {
      url = "https://raw.githubusercontent.com/Homebrew/formula-patches/12f3d34/usbutils/portable.patch";
      sha256 = "0f504a173191a1e1e2f56b41584fcc0468eab7b7dfefd225910b91b5ea65cfbe";
    })
  ];

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ libusb1 python3 ];

  outputs = [ "out" "man" "python" ];
  postInstall = ''
    moveToOutput "bin/lsusb.py" "$python"
  '';

  meta = with lib; {
    homepage = "http://www.linux-usb.org/";
    description = "Tools for working with USB devices, such as lsusb";
    maintainers = with maintainers; [ cafkafk ];
    license = licenses.gpl2Plus;
    platforms = platforms.linux ++ platforms.darwin;
    mainProgram = "lsusb";
  };
}
