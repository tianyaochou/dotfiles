# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ nixpkgs }: {
  # example = pkgs.callPackage ./example { };
  iosevka-bin-nf = nixpkgs.callPackage ./iosevka-bin-nf.nix {};
  pytorch = nixpkgs.callPackage ./pytorch-rocm.nix {};
}
