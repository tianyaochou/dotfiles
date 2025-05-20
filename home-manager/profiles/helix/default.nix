{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [tinymist];
  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs-unstable.helix;
    settings = {
      theme = "kaolin-light";
      editor = {
        true-color = true;
        line-number = "relative";
        undercurl = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
        soft-wrap = {
          enable = true;
        };
        indent-guides = {
          render = true;
          character = "╎";
          skip-levels = 1;
        };
        whitespace = {
          tab = "all";
        };
        preview-completion-insert = false;
        lsp = {
          display-messages = true;
        };
        bufferline = "always";
        inline-diagnostics = {
          cursor-line = "error";
        };
      };
      keys = {
        insert = {
          "C-a" = "goto_first_nonwhitespace";
          "C-e" = "goto_line_end_newline";
          "C-f" = "move_char_right";
          "C-b" = "move_char_left";
          "C-p" = "move_line_up";
          "C-n" = "move_line_down";
        };
      };
    };
    languages = {
      language-server = {
        emmet-language-server = {
          command = "${pkgs.emmet-language-server}/bin/emmet-language-server";
          args = ["--stdio"];
        };
        tinymist = {
          config = {exportPdf = "never";};
        };
        racket-langserver = {
          command = "racket";
          args = ["-l" "racket-langserver"];
        };
        zk = {
          command = "zk";
          args = ["lsp"];
        };
      };
      language = [
        {
          name = "html";
          language-servers = ["emmet-language-server"];
        }
        {
          name = "css";
          language-servers = ["emmet-language-server"];
        }
        {
          name = "racket";
          language-servers = ["racket-langserver"];
        }
        {
          name = "markdown";
          language-servers = ["zk"];
        }
      ];
    };
  };
}
