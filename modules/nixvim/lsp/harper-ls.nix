{
  plugins.lsp.servers.harper_ls = {
    enable = true;
    settings."harper-ls" = {
      linters = {
        boring_words = true;
        linking_verbs = true;
        # Rarely useful with coding
        sentence_capitalization = false;
        spell_check = false;
      };
      codeActions.forceStable = true;
    };
  };
}
