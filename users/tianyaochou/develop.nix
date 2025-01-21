{ config, lib, packages, ... }:
let username = "tianyaochou";
    email = "tianyaochou@fastmail.com";
in
{
  home-manager.users.${username} =
  { pkgs, profiles, ... }: {
    imports = (with profiles; [ shell git restic helix kakoune ]);

    home.packages = with pkgs;
      [
        # Programming
        opam
        cargo
        cargo-generate
        gnumake
        clang
        stack

        vscode

        nil

        iosevka-bin
        (iosevka-bin.override {variant = "Slab";})
        (iosevka-bin.override {variant = "Etoile";})
        (iosevka-bin.override {variant = "Aile";})

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

        qemu
        gdb
        gef
        tio

        wireshark-qt

        haskellPackages.pandoc-crossref
        typst
      ] ++ [ packages.iosevka-nf ];

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

    home.stateVersion = "24.11";
  };
}
