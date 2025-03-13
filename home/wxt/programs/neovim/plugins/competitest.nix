{
  ...
}:
{
  imports = [

  ];
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ta";
      action = "<cmd>CompetiTest add_testcase<cr>";
      options = {
        silent = true;
        desc = "Add Testcase";
      };
    }
    {
      mode = "n";
      key = "<leader>tc";
      action = "<cmd>CompetiTest receive contest<cr>";
      options = {
        silent = true;
        desc = "Receive Contest";
      };
    }
    {
      mode = "n";
      key = "<leader>tp";
      action = "<cmd>CompetiTest receive problem<cr>";
      options = {
        silent = true;
        desc = "Receive Problem";
      };
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = "<cmd>CompetiTest run<cr>";
      options = {
        silent = true;
        desc = "Run Testcase";
      };
    }
    {
      mode = "n";
      key = "<leader>td";
      action = "<cmd>CompetiTest delete_testcase<cr>";
      options = {
        silent = true;
        desc = "Delete Testcase";
      };
    }
    {
      mode = "n";
      key = "<leader>te";
      action = "<cmd>CompetiTest edit_testcase<cr>";
      options = {
        silent = true;
        desc = "Edit Testcase";
      };
    }
  ];
  programs.nixvim.plugins.competitest = {
    enable = true;
    settings = {
      template_file = "/home/wxt/OI/Temp.cpp";
      compile_command = {
        cpp = {
          exec = "g++";
          args = [
            "$(FNAME)"
            "-Wall"
            "-std=c++14"
            "-DONLINE_JUDGE"
            "-fsanitize=undefined,address"
            "-o"
            ".cph/$(FNOEXT).cphbin"
          ];
        };
        c = {
          exec = "gcc";
          args = [
            "$(FNAME)"
            "-Wall"
            "-std=c++14"
            "-DONLINE_JUDGE"
            "-fsanitize=undefined,address"
            "-o"
            ".cph/$(FNOEXT).cphbin"
          ];
        };
      };
      run_command = {
        cpp = {
          exec = "./.cph/$(FNOEXT).cphbin";
        };
        c = {
          exec = "./.cph/$(FNOEXT).cphbin";
        };
      };
      testcases_directory = "./.cph";
      evaluate_template_modifiers = true;
      multiple_testing = 2;
      maximum_time = 20000;
      view_output_diff = true;
    };
  };
}
