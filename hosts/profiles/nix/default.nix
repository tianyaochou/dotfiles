{ config, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [ ./cachix ];

  nix.gc.automatic = true;

  nix.settings = {
    # Prevents impurities in builds
    # HACK: Sandbox is not working properly in macOS
    # See https://github.com/NixOS/nixpkgs/issues/116341
    sandbox = if isDarwin
                 then
                   false
                 else
                   true;

    # Give root user and wheel group special Nix privileges.
    trusted-users = if isDarwin
                   then
                     [ "@admin" ]
                   else
                     [ "root" "@wheel" ];
  };

  # Generally useful nix option defaults
  nix.extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
}
