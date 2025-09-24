# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  inputs,
  withSystem,
  ...
}: let
  lib = inputs.nixpkgs.lib;
in {
  flake = {
    perSystem = {pkgs, ...}: {
      iosevka-bin-nf = pkgs.callPackage ./iosevka-bin-nf.nix {};
      iosevka-nf = pkgs.callPackage ./iosevka-nf.nix {};
      usbutils = pkgs.callPackage ./usbutils.nix {};
    };
    packages = {
      v4l-utils = withSystem lib.platform.linux ({pkgs, ...}: pkgs.callPackage ./v4l-utils.nix {});
      snps-hdmirx = withSystem lib.platform.linux ({pkgs, ...}: pkgs.callPackage ./snps-hdmirx.nix {});
    };
  };
}
