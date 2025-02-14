{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  programs.nixvim.plugins.lsp.servers.clangd.enable = true;
  programs.nixvim.plugins.clangd-extensions = {
    enable = true;
    enableOffsetEncodingWorkaround = true;
  };
  programs.nixvim.extraConfigLua = ''
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "cpp",
        callback = function()
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<F5>",
                ":w<CR>:split<CR>:te g++ '%' -g -DONLINE_JUDGE -std=c++14 -Wall -O0 -o '%:r' -fsanitize=address -fsanitize=undefined<CR>i",
                { silent = true, noremap = true }
            )
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "<F7>",
                ":w<CR>:split<CR>:te g++ '%' -g -std=c++14 -Wall -O0 -o '%:r' -fsanitize=address -fsanitize=undefined<CR>i",
                { silent = true, noremap = true }
            )
            vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<F6>",
            ":w<CR>:split<CR>:te '%:r'<CR>i",
        {silent=true,noremap=true}
      )
        end,
    })
  '';
}
