-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Helper to avoid repeating termcode replacement
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Insert mode mappings
map("i", "jk", "<Esc>")
map("i", "jj", "<Esc>")
map("i", "g'", "<Esc>gcc")

-- Normal mode mappings
map("n", "vm", "va{")
map("n", "<Enter>", "viw")
map("n", "g'", "gcc")
map("n", "U", "<C-r>")
map("n", "k", "gk")
map("n", "j", "gj")
map("n", "zc", "mm")
map("n", "zo", "mk")
map("n", "zr", "zR")
map("n", "zm", "zM")
map("n", "gh", "^")
map("n", "gl", "$")
map("n", "\\", "ggVG$y") -- 注意：原 \\y 在 Vim 中是 <leader>y，但你用了 \\，这里按字面处理
map("n", "\\w", "viwp")
map("n", "\\q", "qa!")
map("n", "<leader>a", "ggVG")
map("n", "<leader>v", "viw")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "\\q", ":q<CR>", { silent = true })
map("n", "<leader>y", "ggVGy")
map("n", "<leader>w", "viwpviwy")
map("n", "<leader>q", "viwy")
map("n", "[", "{")
map("n", "]", "}")
map("n", "<leader>s", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("/<CR>", true, false, true), "n")
end)
map("n", "<leader>d", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("/", true, false, true), "n")
end)
map("n", "3", "#")
map("n", "4", "*")
map("n", "g[", "vi{o<Esc>")
map("n", "g]", "vi{<Esc>")

-- Visual mode mappings
map("v", "m", "a{")
map("v", "<Enter>", "V")
map("v", "q", "<Esc>")
map("v", "g'", "gcc")
map("v", "gh", "^")
map("v", "gl", "$")
map("v", "[", "{")
map("v", "]", "}")
map("v", "a", "y")
map("v", "A", "p")
map("v", "3", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("y/<CR>", true, false, true), "n")
end)
map("v", "4", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("y/<CR>", true, false, true), "n")
end)

-- Settings
vim.opt.ignorecase = true
vim.opt.smartcase = false -- nosmartcase → smartcase = false
