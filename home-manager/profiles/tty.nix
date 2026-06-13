{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;
    enableFishIntegration = true;
    settings = {
      command = "direct:${pkgs.fish}/bin/fish --login --interactive";
      theme = "light:Catppuccin Latte,dark:Dracula";
      macos-option-as-alt = "left";
      notify-on-command-finish = "unfocused";
    };
  };
}
