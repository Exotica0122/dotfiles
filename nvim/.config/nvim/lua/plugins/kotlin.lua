return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {
          cmd_env = {
            JAVA_HOME = vim.fn.expand("~/.sdkman/candidates/java/21.0.6-tem"),
          },
        },
      },
    },
  },
}
