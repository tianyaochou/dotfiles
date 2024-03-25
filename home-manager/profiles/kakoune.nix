{ pkgs, ... }: {
  programs.kakoune = {
    enable = true;
    plugins = with pkgs.kakounePlugins; [  ];
    extraConfig = ''
      eval %sh{${pkgs.kak-lsp}/bin/kak-lsp --kakoune -s $kak_session}
      lsp-enable
    '';
  };
}
