# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  inputs,
  withSystem,
  ...
}: let
  lib = inputs.nixpkgs.lib;
in {
  perSystem = {pkgs, ...}: {
    packages = {
      iosevka-bin-nf = pkgs.callPackage ./iosevka-bin-nf.nix {};
      iosevka-nf = pkgs.callPackage ./iosevka-nf.nix {};
      usbutils = pkgs.callPackage ./usbutils.nix {};
    };
  };
  flake = {
    packages = {
      aarch64-linux.v4l-utils = withSystem "aarch64-linux" ({pkgs, ...}: pkgs.callPackage ./v4l-utils.nix {});
      aarch64-linux.snps-hdmirx = withSystem "aarch64-linux" ({pkgs, ...}: pkgs.callPackage ./snps-hdmirx.nix {});
    };
  };
}
