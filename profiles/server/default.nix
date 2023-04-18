{
  self,
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      coreutils
      git
    ];
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  nix.gc.automatic = true;
}
