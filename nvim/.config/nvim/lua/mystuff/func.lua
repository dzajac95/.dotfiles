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
    vim.api.nvim_set_option_value('readonly', true, {buf=buf})
    vim.api.nvim_set_option_value('modified', false, {buf=buf})
    vim.api.nvim_set_option_value('modifiable', false, {buf=buf})
    vim.api.nvim_set_option_value('swapfile', false, {buf=buf})
    vim.api.nvim_set_option_value('buftype', 'nofile', {buf=buf})
    vim.api.nvim_set_option_value('bufhidden', 'delete', {buf=buf})
    if is_man then
        vim.api.nvim_set_option_value('filetype', 'man', {buf=buf})
    end
end,
{nargs='+'}
)

-- Open a scratch buffer
vim.api.nvim_create_user_command("Scratch", function(params)
    vim.cmd('tabnew ')
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_set_option_value('swapfile', false, {buf=buf})
    vim.api.nvim_set_option_value('buftype', 'nofile', {buf=buf})
    vim.api.nvim_set_option_value('bufhidden', 'delete', {buf=buf})
end,
{}
)

vim.api.nvim_create_user_command("Swap", function(params)
    local swap = require("swap")
    local buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    local col = cursor[2]
    local line = vim.api.nvim_buf_get_lines(buf, row-1, row, false)[1]
    local new_line = swap.swap_args(line, col+1)
    vim.api.nvim_buf_set_lines(buf, row-1, row, false, {new_line})
end,
{}
)
