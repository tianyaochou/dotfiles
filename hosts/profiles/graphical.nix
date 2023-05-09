{ ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
