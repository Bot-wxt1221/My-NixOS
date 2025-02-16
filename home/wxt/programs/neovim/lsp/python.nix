{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  programs.nixvim.plugins.lsp.servers.ruff = {
    enable = true;
    filetypes = [ "python" ];
  };

  programs.nixvim.plugins.conform-nvim.settings.formatters_by_ft = {
    python = [ "ruff" ];
  };

  programs.nixvim.plugins.dap.configurations.python = [
    {
      name = "Launch Django DAP";
      type = "python";
      request = "launch";
      program = {
        __raw = # lua
          ''vim.loop.cwd() .. "/.venv/bin/django-admin" '';
      };
      args = [
        "runserver"
        "--noreload"
      ];
      justMyCode = true;
      django = true;
      console = "integratedTerminal";
      env = {
        "DJANGO_SETTINGS_MODULE" = "true";
        "INTEGREAT_CMS_DEBUG" = "true";
        "INTEGREAT_CMS_SECRET_KEY" = "dummy";
      };
    }
  ];
}
