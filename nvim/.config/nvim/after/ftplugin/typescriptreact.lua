vim.opt_local.sw = 2;
vim.opt_local.ts = 2;
vim.api.nvim_create_user_command('Prettier', '!yarn prettier % --write', {});
