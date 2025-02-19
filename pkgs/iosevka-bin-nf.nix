{
  lib,
  callPackage,
  iosevka-bin,
  nerd-font-patcher,
  variant ? "",
  symbol-fonts ? ["powerline" "fontawesome"],
  extra-option ? "",
  ...
}: let
  patcher = "${nerd-font-patcher}/bin/nerd-font-patcher";
  symbol-options = lib.strings.concatMapStringsSep " " (x: "--" + x) symbol-fonts;
in
  (iosevka-bin.override {variant = variant;}).overrideAttrs (final: prev: {
    pname = prev.pname + "-nf";
    unpackPhase =
      prev.unpackPhase
      + ''
        task(){
          ${patcher} -q ${extra-option} ${symbol-options} $1 -o "$1-dir"
          mv "$1-dir/$(ls -1 $1-dir)" "$(echo $1 | sed -E 's|([a-z\-]+).ttc|\1-nf.ttc|')"
          rmdir "$1-dir"
          rm $1
        }

        pushd $out/share/fonts/truetype
        for font in $(ls -1 .)
        do
          task $font &
        done
      '';
  })
