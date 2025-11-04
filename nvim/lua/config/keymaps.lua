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

vim.keymap.set("n", "3", "#", { silent = true, desc = "restore" })
vim.keymap.set("n", "4", "*", { silent = true, desc = "restore" })
vim.keymap.set("v", "m", "i{", { silent = true, desc = "restore" })

-- 强制设置 Enter 键映射 - 立即设置（使用 remap 允许递归映射到 vm）
vim.keymap.set("n", "<CR>", "vm", { silent = true, remap = true, desc = "backet" })

-- 在多个时机重复设置，确保不被覆盖
local function set_enter_mapping()
  vim.keymap.set("n", "<CR>", "vm", { silent = true, remap = true, desc = "backet" })
end

-- VimEnter 时设置
vim.api.nvim_create_autocmd("VimEnter", {
  callback = set_enter_mapping,
})

-- BufEnter 时设置（每次进入 buffer）
vim.api.nvim_create_autocmd("BufEnter", {
  callback = set_enter_mapping,
})

-- 延迟设置（最后保险）
vim.defer_fn(set_enter_mapping, 500)

vim.keymap.set(
  "n",
  "<leader>ch",
  "<Cmd>ClangdSwitchSourceHeader<CR>",
  { desc = "switch between cpp and hpp", silent = true, noremap = true }
)

vim.keymap.set("n", "--", "<space>bd", { remap = true, silent = true })
vim.keymap.set("n", "_", "<space>wd", { remap = true, silent = true })
vim.keymap.set("n", "Q", "<space>bd", { remap = true, silent = true })

vim.keymap.set("n", "<leader>o", ":lua vim.lsp.buf.code_action()<enter>", { remap = true, silent = true })

vim.keymap.set("n", "g'", "gcc", { remap = true })
vim.keymap.set("n", "<leader>q", ":q", { remap = true })
vim.keymap.set("i", "g'", "<esc>gccA ", { remap = true })
vim.keymap.set("v", "g'", "gc", { remap = true })
