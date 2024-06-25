{ config, lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai";
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
        typst-lsp = {
          config = { exportPdf = "never"; };
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
      ];
    };
  };
}
