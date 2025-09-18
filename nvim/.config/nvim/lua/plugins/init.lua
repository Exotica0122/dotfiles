return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "type-language_server",
        "tailwindcss-language-server",
        "eslint-lsp",
        "prettierd",
        "typescript-language-server",
        "intelephense",
        "js-debug-adapter",
        "elixir-ls",
        "lua-language-server",
        "node-debug2-adapter",
        "pyright",
        "mypy",
        "black",
        "debugpy",
        "ruff",
        "pylint",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "elixir",
        "eex",
        "heex",
        "go",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    -- requires = {
    --   ""
    -- },
    config = function()
      require "configs.dap"
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "microsoft/vscode-js-debug" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  -- @TODO: Fix debugger
  {
    "mxsdev/nvim-dap-vscode-js",
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      -- {
      --   combine_args = true, -- false by default to keep existing behavior
      -- }
    },
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
}
