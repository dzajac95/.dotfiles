vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move visual selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the same spot when using J
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centered when using Ctrl U & D
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Do the same for find next/previous
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever - paste over selection but keep prev selection in buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- search text selected in visual mode
vim.keymap.set("v", "//", "y/\\V<C-R>=escape(@\",'/\')<CR><CR>")

-- replace selected text exactly
vim.keymap.set("v", "/r", "y:%s/\\<<C-R>\"\\>/")

-- Move between splits easier
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")

-- my very own parameter swap!
vim.keymap.set("n", "<leader>s", ":Swap<CR>")
