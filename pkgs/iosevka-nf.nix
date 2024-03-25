{ lib, stdenv, fetchzip, ... }: stdenv.mkDerivation rec {
  name = "Iosevka Nerd Font";
  pname = "iosevka-nf";
  version = "3.1.1";
  src = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/Iosevka.zip";
    hash = "sha256-zrBRWAMZ3AqYl5lBadv9U3tMh9KYssnbmzLUt4PQR2Q=";
    stripRoot = false;
  };

  buildPhase = "";
  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp IosevkaNerdFont* $out/share/fonts/truetype
  '';
}
