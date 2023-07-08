{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    keybindings = [
      {
        key = "ctrl+g";
        command = "vscode-neovim.escape";
        when = "editorTextFocus";
      }
    ];
  };
}
