{ pkgs, ... }:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-full
        supertabular
        csquotes
        textpos
        appendix
        inconsolata
        lstaddons
        pgfplots
        todonotes
        xetex
        ;
    }
  );
in
{
  programs.nixvim.plugins.vimtex = {
    enable = true;
    texlivePackage = tex;
    settings = {
      compiler_method = "latexmk";
      view_method = "sioyek";
    };
  };
  programs.nixvim.opts.conceallevel = 2;

  programs.nixvim.plugins.lsp.servers.ltex.enable = true;
  programs.nixvim.plugins.conform-nvim.settings.formatters_by_ft = {
    bib = [ "latexindent" ];
    plaintex = [ "latexindent" ];
    tex = [ "latexindent" ];
    quarto = [ "latexindent" ];
    context = [ "latexindent" ];
  };
  programs.nixvim.extraPackages = [ tex ];
}
