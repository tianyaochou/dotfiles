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
      then emacs
      else emacs
    )
  ];

  # home.file.".doom.d" = {
  #   source = ./doom.d;
  # };
}
