{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ texlab languagetool (if stdenv.isDarwin then emacs29-macport else emacs29-gtk3) (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ])) ];

  home.file.".doom.d" = {
    source = ./doom.d;
  };
}
