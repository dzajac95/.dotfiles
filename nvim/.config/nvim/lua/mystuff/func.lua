-- Function to trim whitespace from end of all lines in current bufffer
vim.api.nvim_create_user_command("TrimWhiteSpace", function()
    local view = vim.fn.winsaveview()
    vim.cmd("%s/\\s\\+$//e")
    -- Restoring saved view returns cursor to original position
    vim.fn.winrestview(view)
end,
{}
)

-- Define a Lua function to run a shell command and open the output in a new tab
vim.api.nvim_create_user_command("Cmd", function(params)
    vim.print(vim.inspect(params))
    local command = params.args
    local is_man = command:match("man")
    -- Execute the shell command and capture its output
    local output = vim.fn.systemlist(command)

    -- Create a new tab
    vim.cmd('tabnew ' .. command)

    -- Get the current buffer in the new tab
    local buf = vim.api.nvim_get_current_buf()

    -- Insert the captured output into the buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

    -- Set the buffer to read-only to prevent accidental changes
    vim.api.nvim_buf_set_option(buf, 'readonly', true)
    vim.api.nvim_buf_set_option(buf, 'modified', false)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'swapfile', false)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'delete')
    if is_man then
        vim.api.nvim_buf_set_option(buf, 'filetype', 'man')
    end
end,
{nargs='+'}
)
