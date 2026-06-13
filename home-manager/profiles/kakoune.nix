{pkgs, ...}: {
  programs.kakoune = {
    enable = true;
    plugins = with pkgs.kakounePlugins; [];
    extraConfig = ''
      eval %sh{ kak-lsp --kakoune -s $kak_session }
      lsp-enable

      eval %sh{ kak-tree-sitter -dks --init $kak_session }
    '';
  };

  home.packages = with pkgs; [
    kakoune-lsp
    kak-tree-sitter-unwrapped
  ];
}
