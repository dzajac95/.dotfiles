-- Add numbers to each line on the left-hand side.
vim.opt.number = true
vim.opt.relativenumber = true

-- Make cursor always blocky :)
vim.opt.guicursor = ""

-- Set shift width to 4 spaces.
vim.opt.shiftwidth = 4

-- Set tab width to 4 columns.
vim.opt.tabstop = 4

-- Use space characters instead of tabs.
vim.opt.expandtab = true

-- Use smart tab. This option makes <TAB> and <BS> operate using shiftwidth.
vim.opt.smarttab = true

-- Do not save backup files.
vim.opt.backup = false

-- Disable mouse
vim.opt.mouse = ''

-- Do not let cursor scroll below or above N number of lines when scrolling.
vim.opt.scrolloff = 10

-- Do not wrap lines. Allow long lines to extend as far as the line goes.
-- vim.opt.wrap = false

-- While searching though a file incrementally highlight matching characters as you type.
vim.opt.incsearch = true

-- Ignore capital letters during search.
vim.opt.ignorecase = true

-- Override the ignorecase option if searching for capital letters.
-- This will allow you to search specifically for capital letters.
vim.opt.smartcase = true

-- Show partial command you type in the last line of the screen.
vim.opt.showcmd = true

-- Show the mode you are on the last line.
vim.opt.showmode = true

-- Show matching words during a search.
vim.opt.showmatch = true

-- Use highlighting when doing a search.
vim.opt.hlsearch = false

-- Set the commands to save in history default number is 20.
vim.opt.history = 100

-- Set cino to line up new line with unclosed paren directly after first
-- opening paren
vim.opt.cinoptions = ':0,l1,g0,(0,W4,m1")'

-- Wild Menu settings
vim.opt.wildmenu = true

vim.opt.updatetime = 50

-- vim.opt.timeoutlen = 200
