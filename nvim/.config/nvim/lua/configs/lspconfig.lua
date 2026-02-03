-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require("nvchad.configs.lspconfig")
local servers = { "html", "cssls", "ts_ls", "tailwindcss", "eslint", "intelephense" }
local on_attach = nvlsp.on_attach
local capabilities = nvlsp.capabilities

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(lsp)
end

vim.lsp.config("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { "go.work", "go.mod", ".git" }))
  end,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
vim.lsp.enable("gopls")

vim.lsp.config("elixirls", {
  cmd = { "/Users/peteran/.languages/elixir-ls/language_server.sh" },
})
vim.lsp.enable("elixirls")

local python_servers = { "pyright", "ruff" }
for _, lsp in ipairs(python_servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
  })
  vim.lsp.enable(lsp)
end
