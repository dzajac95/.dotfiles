local mod = {}

local function push_bracket(stack, b)
    stack[#stack+1] = b
end

local function bracket_match(a, b)
    return a == '(' and b == ')' or
           b == '(' and a == ')' or
           a == '[' and b == ']' or
           b == '[' and a == ']' or
           a == '{' and b == '}' or
           b == '{' and a == '}'
end

local function is_opening(b)
    return b == '(' or b == '[' or b == '{'
end

local function is_closing(b)
    return b == ')' or b == ']' or b == '}'
end

local function pop_bracket(stack, b)
    if #stack < 1 then
        return false
    end
    local a = table.remove(stack, #stack)
    return bracket_match(a, b)
end

local function find_brackets(line, col)
    local bracket_stack = {}
    local i = col
    local c

    -- go left
    while i > 0 do
        c = string.sub(line, i, i)
        if is_closing(c) then
            push_bracket(bracket_stack, c)
        elseif is_opening(c) then
            local success = pop_bracket(bracket_stack, c)
            if not success and #bracket_stack < 1 then
                break
            end
        end
        i = i - 1
    end
    if i == 0 then
        return nil
    end
    local l_idx = i

    -- reset
    i = col+1
    bracket_stack = {}
    -- go right
    while i <= string.len(line) do
        c = string.sub(line, i, i)
        if is_opening(c) then
            push_bracket(bracket_stack, c)
        elseif is_closing(c) then
            local success = pop_bracket(bracket_stack, c)
            if not success and #bracket_stack < 1 then
                break
            end
        end
        i = i + 1
    end
    if i > string.len(line) then
        return nil
    end

    local r_idx = i
    if bracket_match(string.sub(line, l_idx, l_idx), string.sub(line, r_idx, r_idx)) then
        return {l_idx, r_idx}
    else
        return nil
    end
end

local function trim(str)
    local i = 1
    while i < string.len(str) do
        local c = string.sub(str, i, i)
        if c ~= " " then
            break
        end
        i = i + 1
    end
    local l = i
    i = string.len(str)
    while i > 0 do
        local c = string.sub(str, i, i)
        if c ~= " " then
            break
        end
        i = i -1
    end
    local r = i
    return string.sub(str, l, r)
end

local function split_args(args)
    local split = {}
    local stack = {}
    local word_start = 1
    local word_end = 0
    for i=1,string.len(args) do
        local c = string.sub(args, i, i)
        if (c == "," or i==string.len(args)) and #stack < 1 then
            if i < string.len(args) then
                word_end = i-1
            else
                word_end = i
            end
            split[#split+1] = {str = trim(string.sub(args, word_start, word_end)),
                               beg = word_start,
                               fin = word_end}
            word_start = i + 1
        elseif is_opening(c) then
            push_bracket(stack, c)
        elseif is_closing(c) then
            pop_bracket(stack, c)
        end
    end
    return split
end

mod.swap_args = function(line, col)
    local idxs = find_brackets(line, col)
    if not idxs then
        -- nothing to do, couldn't find enclosing brackets
        return line
    end
    local l_idx = idxs[1]
    local r_idx = idxs[2]

    local arg_str = string.sub(line, l_idx+1, r_idx-1)
    local arg_col = col - l_idx
    local arg_list = split_args(arg_str)
    if #arg_list <= 1 then
        -- nothing to do, not enough args to swap
        return line
    end

    -- locate 'selected' argument
    local sel_idx = 1
    for i=1,#arg_list do
        arg = arg_list[i]
        if arg.beg <= arg_col and arg_col <= arg.fin then
            sel_idx = i
            break
        end
    end

    -- first part of input string
    local final_str = string.sub(line, 1, l_idx)
    -- make sure sel idx > 1 (we swap selected with value to its left)
    if sel_idx == 1 then
        sel_idx = sel_idx + 1
    end
    local first_print = false
    -- start with values to the left of the pair to be swapped
    for i=1,sel_idx-2 do
        if first_print then
            final_str = final_str .. ", "
        end
        final_str = final_str .. arg_list[i].str
        first_print = true
    end
    if first_print then
        final_str = final_str .. ", "
    end
    -- swap selected pair
    final_str = final_str .. arg_list[sel_idx].str .. ", " .. arg_list[sel_idx-1].str
    -- add remaining args
    for i=sel_idx+1,#arg_list do
        final_str = final_str .. ", " .. arg_list[i].str
    end
    -- append rest of input string
    final_str = final_str .. string.sub(line, r_idx)
    return final_str
end
return mod
