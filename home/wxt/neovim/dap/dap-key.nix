[
  {
    mode = "n";
    key = "<leader>lR";
    action = "<cmd>lua require'dap'.run_to_cursor()<cr>";
    options = {
      silent = true;
      desc = "Run to Cursor";
    };
  }

  {
    mode = "n";
    key = "<leader>lu";
    action = "<cmd>lua require'dap'.step_out()<cr>";
    options = {
      silent = true;
      desc = "Step Out";
    };
  }
  {
    mode = "n";
    key = "<leader>lx";
    action = "<cmd>lua require'dap'.terminate()<cr>";
    options = {
      silent = true;
      desc = "Terminate";
    };
  }
  {
    mode = "n";
    key = "<leader>lt";
    action = "<cmd>lua require'dap'.toggle_breakpoint()<cr>";
    options = {
      silent = true;
      desc = "Toggle Breakpoint";
    };
  }
  {
    mode = "n";
    key = "<leader>ls";
    action = "<cmd>lua require'dap'.continue()<cr>";
    options = {
      silent = true;
      desc = "Start";
    };
  }
  {
    mode = "n";
    key = "<leader>lr";
    action = "<cmd>lua require'dap'.repl.toggle()<cr>";
    options = {
      silent = true;
      desc = "Toggle Repl";
    };
  }
  {
    mode = "n";
    key = "<leader>lq";
    action = "<cmd>lua require'dap'.close()<cr>";
    options = {
      silent = true;
      desc = "Quit";
    };
  }
  {
    mode = "n";
    key = "<leader>lp";
    action = "<cmd>lua require'dap'.pause.toggle()<cr>";
    options = {
      silent = true;
      desc = "Pause";
    };
  }
  {
    mode = "n";
    key = "<leader>lo";
    action = "<cmd>lua require'dap'.step_over()<cr>";
    options = {
      silent = true;
      desc = "Step Over";
    };
  }
  {
    mode = "n";
    key = "<leader>li";
    action = "<cmd>lua require'dap'.step_into()<cr>";
    options = {
      silent = true;
      desc = "Step Into";
    };
  }
  {
    mode = "n";
    key = "<leader>lS";
    action = "<cmd>lua require'dap.ui.widgets'.scopes()<cr>";
    options = {
      silent = true;
      desc = "Scopes";
    };
  }
  {
    mode = "n";
    key = "<leader>lh";
    action = "<cmd>lua require'dap.ui.widgets'.hover()<cr>";
    options = {
      silent = true;
      desc = "Hover Variables";
    };
  }
  {
    mode = "n";
    key = "<leader>lg";
    action = "<cmd>lua require'dap'.session()<cr>";
    options = {
      silent = true;
      desc = "Get Session";
    };
  }
  {
    mode = "n";
    key = "<leader>le";
    action = "<cmd>lua require'dapui'.eval()<cr>";
    options = {
      silent = true;
      desc = "Evaluate";
    };
  }
  {
    mode = "n";
    key = "<leader>ld";
    action = "<cmd>lua require'dap'.disconnect()<cr>";
    options = {
      silent = true;
      desc = "Disconnect";
    };
  }

  {
    mode = "n";
    key = "<leader>lE";
    action = "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>";
    options = {
      silent = true;
      desc = "Evaluate Input";
    };
  }

  {
    mode = "n";
    key = "<leader>lC";
    action = "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>";
    options = {
      silent = true;
      desc = "Conditional Breakpoint";
    };
  }
  {
    mode = "n";
    key = "<leader>lU";
    action = "<cmd>lua require'dapui'.toggle()<cr>";
    options = {
      silent = true;
      desc = "Toggle UI";
    };
  }
  {
    mode = "n";
    key = "<leader>lb";
    action = "<cmd>lua require'dap'.step_back()<cr>";
    options = {
      silent = true;
      desc = "Step Back";
    };
  }

  {
    mode = "n";
    key = "<leader>lc";
    action = "<cmd>lua require'dap'.continue()<cr>";
    options = {
      silent = true;
      desc = "Continue";
    };
  }

]
