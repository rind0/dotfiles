local M = {}

M.float_opts = {
    border = 'rounded',
    focusable = false,
    source = 'always',
}

function M.disable_cursor_hold()
    vim.opt.eventignore:append('CursorHold')
    vim.api.nvim_create_augroup('LspConfig.DisableCursorHold', { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufHidden', 'InsertCharPre' }, {
        group = 'LspConfig.DisableCursorHold',
        buffer = vim.api.nvim_get_current_buf(),
        once = true,
        desc = 'Prevent floaoting window with diagnostic opening while one with hover information is opened',
        callback = function()
            vim.opt.eventignore:remove('CursorHold')
        end
    })
end

function M.hover_or_open_vim_help()
    if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
        vim.cmd([[silent! execute 'h' .. expand('<cword>')]])
    else
        vim.lsp.buf.hover()
        M.disable_cursor_hold()
    end
end

function M.send_key(command, bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local floating_window = vim.F.npcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_floating_preview')
    local escaped_command = vim.api.nvim_replace_termcodes(command, true, false, true)
    local win_height = vim.api.nvim_win_get_height(floating_window)
    local buf_line_count = vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf())
    if floating_window and
        vim.api.nvim_win_is_valid(floating_window) and
        win_height < buf_line_count then
        vim.api.nvim_win_call(floating_window, function()
            vim.cmd(([[execute "normal %s"]]):format(escaped_command))
        end)
        return
    end
    vim.api.nvim_feedkeys(escaped_command, 'n', true)
end

function M.get_nvim_lsp_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = {
        valueSet = {
            1
        },
    }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    }
    return capabilities
end

return M
