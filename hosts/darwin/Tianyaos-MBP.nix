{ config, pkgs, profiles, users, ... }:
let 
  hostName = "Tianyaos-MBP";
in
{
  imports = with profiles; [ darwin nix utils sops ] ++ (with users.tianyaochou; [ darwin develop ]);
  programs.fish.enable = true;
  # environment.shells = with pkgs; [ fish ];

  # Homebrew
  # system.activationScripts.homebrew.enable = false;
  homebrew.global.brewfile = true;
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "uninstall";
  homebrew.taps = [ "homebrew/cask" "homebrew/cask-drivers" ];
  homebrew.brews = [
    "lux"
    "gmp"
    "cloudflared"
  ];
  homebrew.casks = [
    "steam"
    "telegram"
    "appcleaner"
    "blockblock"
    "iina"
    "keka"
    "launchbar"
    "bettertouchtool"
    "thingsmacsandboxhelper"
    "shottr"
    "obsidian"
    "notion"
    "busycal"
    "pdf-expert"
    "skim"
    "racket"
    "visual-studio-code"
    "dash"
    "vmware-fusion"
    "zoom"
    "zotero"
    "motrix"
    "transmit"
    "iterm2"
    "keybase"
    "quarto"
    "anki"

    "blackhole-16ch"
    "soundsource"
    "macfuse"

    "clashx"
    "calibre"
    "netnewswire"
    "discord"
    "drawio"
    "google-chrome"
    "obsidian"
  ];

  # HACK: This is sloooooooooooowwwww
  # homebrew.masApps = {
  #   "1Password 7" = 1333542190;
  #   Keynote = 409183694;
  #   Numbers = 409203825;
  #   Pages = 409201541;
  #   "Pixelmator Pro" = 1289583905;
  #   RunCat = 1429033973;
  #   StopTheMadness = 1376402589;
  #   OneDrive = 823766827;
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
