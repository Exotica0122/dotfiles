require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- DAP (debugger) mappings
-- Set keymaps to control the debugger
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "Open debugging sidebar" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continue the debugger" })

map("n", "<F5>", require("dap").continue)
map("n", "<F10>", require("dap").step_over)
map("n", "<F11>", require("dap").step_into)
map("n", "<F12>", require("dap").step_out)
-- vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
-- vim.keymap.set('n', '<leader>B', function()
--   require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
-- end)

map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "Debug go test" })
map("n", "<leader>dgl", function()
  require("dap-go").debug_last()
end, { desc = "Debug last go test" })

-- Git mappings
map("n", "<leader>gbf", "<cmd> Git blame <CR>", { desc = "Show git blame file" })
map("n", "<leader>gbr", "<cmd> Telescope git_branches <CR>", { desc = "Show git branch" })
map("n", "<leader>gdv", "<cmd> Gvdiff <CR>", { desc = "Show git diff file" })
map("n", "<leader>gdt", "<cmd> Git difftool <CR>", { desc = "Show git diff tool" })

map("n", "<leader>gpu", "<cmd> Git pull <CR>", { desc = "Git pull" })
map("n", "<leader>gs", "<cmd> Git <CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd> Git commit <CR>", { desc = "Git commit" })
map("n", "<leader>gw", "<cmd> Gwrite <CR>", { desc = "Git write commit" })
map("n", "<leader>gps", "<cmd> Git push <CR>", { desc = "Git push" })

-- map("n", "<leader>gr", "<cmd> G refresh <CR>", { desc = "Refresh git" })

-- Diagnostic mappings
map("n", "<leader>di", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic under cursor" })

-- Terminal mappings

-- Toggle (?) maybe... I don't like this at the time of writing
map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

-- Floating terminal
-- map({ "n", "t" }, "<leader>fv", function()
--   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
-- end, { desc = "terminal toggleable vertical term" })
--
-- map({ "n", "t" }, "<leader>fh", function()
--   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
-- end, { desc = "terminal toggleable horizontal term" })

vim.keymap.set({ "n", "t" }, "<leader>ft", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

vim.keymap.set(
  "t",
  "<Esc>",
  "<C-\\><C-n>:lua require('nvchad.term').close_term()<CR>",
  { noremap = true, silent = true }
)

-- Commenting
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
  return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
      or get_option(filetype, option)
end
