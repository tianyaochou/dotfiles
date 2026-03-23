{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableFishIntegration = true;
    settings = {
      command = "direct:${pkgs.fish}/bin/fish --login --interactive";
      theme = "light:Catppuccin Latte,dark:Dracula";
      macos-option-as-alt = "left";
      notify-on-command-finish = "unfocused";
    };
  };
}
