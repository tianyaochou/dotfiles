{ config, lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
      };
      keys = {
        insert = {
          "C-a" = "goto_first_nonwhitespace";
          "C-e" = "goto_line_end";
          "C-f" = "move_char_right";
          "C-b" = "move_char_left";
          "C-p" = "move_line_up";
          "C-n" = "move_line_down";
        };
      };
    };
  };
}
