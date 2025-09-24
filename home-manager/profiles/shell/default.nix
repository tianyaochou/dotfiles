{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.fish];
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
      source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = "$all";
      right_format = "$time";
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      git_branch = {
        symbol = "";
        style = "bold green";
      };
      direnv = {
        disabled = false;
      };
      time = {
        disabled = false;
      };
      custom = {
        ledger = {
          command = "if hledger check -s; echo ✅; else; echo ❌; end";
          detect_extensions = ["journal" "j" "hledger"];
          symbol = "🧮 ";
          style = "bold red";
        };
      };
    };
  };

  programs.zoxide.enable = true;
  programs.skim = {
    enable = true;
    defaultOptions = [
      "--ansi"
    ];
    fileWidgetOptions = [
      "--preview 'bat --color always {}'"
    ];
    changeDirWidgetOptions = [
      "--preview 'eza --tree {} --color always --level 3'"
    ];
  };
  programs.nix-index.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.eza = {
    enable = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
  programs.bat.enable = true;
}
