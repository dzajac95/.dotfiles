vim.filetype.add({
    extension = {
        launch = 'xml'
    }
})

vim.api.nvim_create_autocmd({"Filetype"}, {
    pattern = {"cpp"},
    command = "setlocal ts=2 sw=2",
})

vim.api.nvim_create_autocmd({"Filetype"}, {
    pattern = {"c"},
    command = "setlocal cindent"
})
