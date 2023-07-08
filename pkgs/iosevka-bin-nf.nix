{ callPackage, stdenv, iosevka-bin, nerd-font-patcher, variant ? "", ... }:

let iosevka-bin = callPackage iosevka-bin { variant = variant; };
    patcher = "${nerd-font-patcher}/bin/nerd-font-patcher";
in iosevka-bin.overrideAttrs (final: prev: {
  pname = prev.pname + "nf";
  unpackPhase = prev.unpackPhase ++ ''
    for font in $(ls -1 $out/share/fonts/truetype) do
      ${patcher} $font -o "$font-dir"
      mv "$font-dir/$(ls -1 $font-dir)" "$font-nf"
      rmdir "$font-dir"
    done
  '';
})
