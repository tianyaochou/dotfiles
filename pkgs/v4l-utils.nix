{
  stdenv,
  lib,
  fetchurl,
  meson,
  ninja,
  perl,
  argp-standalone,
  libjpeg,
  udev,
}:

stdenv.mkDerivation rec {
  pname = "v4l-utils";
  version = "1.28.1";

  src = fetchurl {
    url = "https://linuxtv.org/downloads/${pname}/${pname}-${version}.tar.xz";
    hash = "sha256-D6B1zlm2YYhHr26hkbYVVWXMqkTeBQRYHd/teVoyioI=";
  };

  nativeBuildInputs = [
    meson
    ninja
    perl
  ];

  buildInputs =
    [ udev ]
    ++ lib.optional (!stdenv.hostPlatform.isGnu) argp-standalone;

  configurePhase = ''
    meson setup build/
  '';

  buildPhase = ''
    ninja -C build/
  '';

  installPhase = ''
    mkdir $out
    DESTDIR=$out ninja -C build/ install
  '';

  propagatedBuildInputs = [ libjpeg ];

  postPatch = ''
    patchShebangs utils/
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "V4L utils and libv4l, provide common image formats regardless of the v4l device";
    homepage = "https://linuxtv.org/projects.php";
    changelog = "https://git.linuxtv.org/v4l-utils.git/plain/ChangeLog?h=v4l-utils-${version}";
    license = with licenses; [
      lgpl21Plus
      gpl2Plus
    ];
    maintainers = with maintainers; [ codyopel ];
    platforms = platforms.linux;
  };
}
