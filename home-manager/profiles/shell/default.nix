{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.fish ];
  programs.fish = {
    enable = true;
    plugins = with pkgs; [
      {
        name = "done";
        src = fishPlugins.done;
      }
      {
        name = "tide";
        src = fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "main";
          sha256 = "1c2E3UC3r9hPfijAQoZ/+4yXieFxC4+hkk7wUyr30NM=";
        };
      }
      {
        name = "autopair.fish";
        src = fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "main";
          sha256 = "l6WJ2kjDO/TnU9FSigjxk5xFp90xl68gDfggkE/wrlM=";
        };
      }
    ];

    shellInit = ''
      ### Add nix binary paths to the PATH
      # Perhaps someday will be fixed in nix or nix-darwin itself
      if test (uname) = Darwin
        fish_add_path --prepend --global "/etc/profiles/per-user/tianyaochou/bin" /run/current-system/sw/bin
      end
      fish_add_path $HOME/.ghcup/bin
      fish_add_path $HOME/.cargo/bin
      source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
    '';

    interactiveShellInit = ''
      set --global tide_character_icon λ
      set --global VISUAL "emacs"
      set --global EDITOR $VISUAL
    '';
  };

  programs.zoxide.enable = true;
  programs.skim.enable = true;
}
