{ pkgs, ... }:
{

  services.displayManager.sddm.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    xkb.layout = "us";
    videoDrivers = [ "i915" ];
  };

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
}
