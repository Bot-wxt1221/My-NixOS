{
  pkgs,
  ...
}:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-sops
  ];
  programs.nixvim.extraConfigLuaPost = ''
    require("nvim_sops").setup({
      enabled = true,
      debug = true,
    })
    vim.keymap.set("n", "<leader>qe", vim.cmd.SopsEncrypt, { desc = "[E]ncrypt [F]ile" })
    vim.keymap.set("n", "<leader>qd", vim.cmd.SopsDecrypt, { desc = "[D]ecrypt [F]ile" })
  '';
}
