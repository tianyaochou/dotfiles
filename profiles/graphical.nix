{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.systemPackages = [
    pkgs.kitty
  ];
}
