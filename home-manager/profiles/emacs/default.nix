{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-doom-emacs.hmModule ];

  home.packages = with pkgs; [ texlab ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    doomPackageDir = pkgs.linkFarm "my-doom-packages" [
      # straight needs a (possibly empty) `config.el` file to build
      { name = "config.el"; path = pkgs.emptyFile; }
      { name = "init.el"; path = ./doom.d/init.el; }
      { name = "packages.el"; path = ./doom.d/packages.el; }
    ];
  };
}
