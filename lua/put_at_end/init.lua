--- Puts 'char' at the end of the line the cursor is currently on
--- If the line has a comment it will put 'char' 1 character before the comment, buffer has to have defined 'commentstring' for it to work.
---@param char string
local function f(char, commentstring)
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1 -- it is (1,0)-indexed and nvim_buf_set_text is 0 indexed

    local current_line = vim.api.nvim_get_current_line()
    local col = #current_line -- nvim_buf_set_text is 0-indexed

    if vim.bo.commentstring == nil then
        vim.api.nvim_buf_set_text(0, row, col, row, col, { char })
        return
    end

    local pattern = commentstring
        :gsub("([%^%$%(%)%.%[%]%*%+%-%?])", "%%%1") -- espace all the magic lua characters
        :gsub("%%s", "%%s%*", 1) -- add '*' after '%s' to handle no space case
        :gsub("%s", "") -- remove all the spaces from the pattern

    local start, _ = string.find(current_line, pattern)

    if start == nil then
        vim.api.nvim_buf_set_text(0, row, col, row, col, { char })
    else
        if start >= 2 then
            vim.api.nvim_buf_set_text(0, row, start - 2, row, start - 2, { char }) -- put two characters before
        else
            vim.api.nvim_buf_set_text(0, row, start - 1, row, start - 1, { char }) -- put one character before
        end
    end
end

local double_slash_filetypes = { "cpp", "c" }

local function f_helper(char)
    if vim.tbl_contains(double_slash_filetypes, vim.bo.filetype) then -- handle c/cpp case
        f(char, [[//%s]])
    else
        f(char, vim.bo.commentstring)
    end
end

local put_at_end = {}

--- Puts 'str' at the end of the current line
--- If the line has a comment it will be put before the comment.
---@param str string
put_at_end.put = function(str)
    f_helper(str)
end

--- Puts ';' at the end of the current line
--- If the line has a comment it will be put before the comment.
put_at_end.put_semicolon = function()
    f_helper(";")
end

--- Puts '.' at the end of the current line
--- If the line has a comment it will be put before the comment.
put_at_end.put_period = function()
    f_helper(".")
end

--- Puts ',' at the end of the current line
--- If the line has a comment it will be put before the comment.
put_at_end.put_comma = function()
    f_helper(",")
end

--- Puts '?' at the end of the current line
--- If the line has a comment it will be put before the comment.
put_at_end.put_questionmark = function()
    f_helper("?")
end

return put_at_end
