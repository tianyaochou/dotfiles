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
      fish_add_path $HOME/.cargo/bin
      fish_add_path $HOME/.config/emacs/bin
      source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
    '';

    interactiveShellInit = ''
      set --global VISUAL "emacsclient -nw"
      set --global EDITOR $VISUAL
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      git_branch = {
        symbol = "";
        style = "bold green";
      };
      nix_shell = {
        heuristic = if pkgs.stdenv.isDarwin then false else true;
      };
    };
  };

  programs.zoxide.enable = true;
  programs.skim.enable = true;
}
