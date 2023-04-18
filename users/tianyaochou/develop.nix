{ self, pkgs, system, config, hmUsers, lib, suites, ... }:
let username = "tianyaochou";
    email = "tianyaochou@fastmail.com";
in
{
  home-manager.users.${username} =
  { pkgs, suites, ... }: {
    home.packages = with pkgs;
      [
        # Programming
        opam
        (python310.withPackages (p: with p;[ jupyter pygments ]))
        rustup
        agda

        nil

        # Utility
        du-dust # Dist Usage rewriten in rust
        entr
        ffmpeg
        mat2
        gh
        pandoc
        yubikey-manager
        ocrmypdf
        tesseract
        fontconfig

        haskellPackages.pandoc-crossref
        texlive.combined.scheme-full
      ];

    programs.git = {
      userName = username;
      userEmail = email;
    };

    programs.gpg = {
      enable = true;
    };

    home.stateVersion = "22.11";
  };
}
