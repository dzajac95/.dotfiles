require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'Mofiqul/vscode.nvim'},
    {'tpope/vim-repeat'},
    {'tpope/vim-fugitive'},
    {'tpope/vim-commentary'},
    {'tpope/vim-surround'},
    {'tpope/vim-abolish'},
    {'junegunn/vim-easy-align'},
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
}
)
