function TrimWhitespace()
    local view = vim.fn.winsaveview()
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.winrestview(view)
end
