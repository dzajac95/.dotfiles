local builtin = require("telescope.builtin")
require("telescope").load_extension("fzf")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>phf", function()
    builtin.find_files({no_ignore=true, no_ignore_parent=true})
end, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})

vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>prs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > "), use_regex=true })
end)
