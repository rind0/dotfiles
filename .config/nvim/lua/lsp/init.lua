local on_attach = function(client)
    local border_opts = {
        border = "single",
        focusable = false,
        scope = "line",
    }

    vim.wo.signcolumn = 'yes'
    local maps = {
        {'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>'},
        {'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>'},
        {'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
        {'n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
        {'n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>'},
        {'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>'},
        {'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>'},
        {'n', '<Leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>'},
        {'n', 'gl', '<cmd>lua vim.lsp.buf.document_highlight()<CR>'},
        {'n', 'gm', '<cmd>lua vim.lsp.diagnostic.open_float()<CR>'},
        {'n', 'g0', '<cmd>Denite lsp/document_symbol -auto-action=highlight<CR>'},
        {'n', 'gr', '<cmd>Denite lsp/references -auto-action=preview_bat<CR>'},
    }
    for _, map in ipairs(maps) do
        vim.api.nvim_buf_set_keymap(0, map[1], map[2], map[3], {noremap = true})
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false,
          float = border_opts,
        }
    )
    vim.api.nvim_exec(
        [[
            augroup MyLspSettings
                autocmd!
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]],
        false
    )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = {
        1
    }
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local lsp_config = require('lspconfig')
lsp_config.gdscript.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    init_options = {
        documentFormatting = true
    },
    settings {
        rootMarkers = {
            ".git/"
        },
        languages = {
            gdscript = {
                formatCommand = "gdformat -l 80 -",
                formatStdin = true,
            },
        },
    },
}

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        }
    }
})
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    server:setup(opts)
end)
