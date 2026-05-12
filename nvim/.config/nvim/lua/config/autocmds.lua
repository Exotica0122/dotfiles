-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Reload buffer when the file changes on disk (e.g. Claude Code edits it from another pane).
-- LazyVim already sets `autoread` + a FocusGained checktime, but that won't fire when nvim
-- is the currently-focused window. Poll on CursorHold and notify on actual reload.
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("auto_checktime_external", { clear = true }),
  desc = "Detect external file changes",
  command = "if mode() !~ '[cr!t]' | checktime | endif",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("auto_checktime_notify", { clear = true }),
  desc = "Notify after buffer auto-reloads",
  callback = function()
    vim.notify("Buffer reloaded (changed on disk)", vim.log.levels.INFO, { title = "autoread" })
  end,
})
