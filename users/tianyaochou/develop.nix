{ inputs, hmProfiles, ... }:
let username = "tianyaochou";
    email = "tianyaochou@fastmail.com";
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; profiles = hmProfiles; };
  home-manager.users.${username} =
  { pkgs, profiles, ... }: {
    imports = (with profiles; [ shell git emacs restic vscode helix ]);

    home.packages = with pkgs;
      [
        # Programming
        opam
        (python310.withPackages (p: with p;[ jupyter pygments ]))
        rustup
        agda
        stack
        ghc
        haskell-language-server

        nil

        iosevka-bin
        (iosevka-bin.override {variant = "slab";})
        (iosevka-bin.override {variant = "etoile";})

        # Utility
        du-dust # Dist Usage rewritten in rust
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
        typst
      ];

    programs.git = {
      userName = username;
      userEmail = email;
    };

    programs.gpg = {
      enable = true;
      publicKeys = [
        {
          source = pkgs.fetchurl {
            url = "https://github.com/tianyaochou.gpg";
            sha256 = "b3433c4d553d826ecc64273c55f229a3aa583e551c62ae08c2d3d2362a68eb20";
          };
        }
      ];
    };

    home.stateVersion = "22.11";
  };
}
