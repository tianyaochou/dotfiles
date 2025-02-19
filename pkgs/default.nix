# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs }: {
  # example = pkgs.callPackage ./example { };
  iosevka-bin-nf = pkgs.callPackage ./iosevka-bin-nf.nix {};
  iosevka-nf = pkgs.callPackage ./iosevka-nf.nix {};
  usbutils = pkgs.callPackage ./usbutils.nix {};
  v4l-utils = pkgs.callPackage ./v4l-utils.nix {};
  snps-hdmirx = pkgs.callPackage ./snps-hdmirx.nix {};
  guix = pkgs.callPackage ./guix.nix {};
}
