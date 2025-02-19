{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    texlab
    languagetool
    (
      if stdenv.isDarwin
      then emacs29-macport
      else emacs29-gtk3
    )
  ];

  home.file.".doom.d" = {
    source = ./doom.d;
  };
}
