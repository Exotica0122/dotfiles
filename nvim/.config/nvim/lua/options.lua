require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt = 'both' -- to enable cursorline!

vim.opt.scrolloff = 10

vim.opt.number = true
vim.opt.relativenumber = true

-- Format on save
vim.api.nvim_command "au BufWritePost *.lua lua vim.lsp.buf.format()"
vim.api.nvim_command "au BufWritePost *.ex,*.exs,*.heex lua vim.lsp.buf.format()"
vim.api.nvim_command "au BufWritePost *.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format()"
