local utils = require 'utils'
local lsp_utils = require 'plugins/lsp/utils'

local M = {}

local general = {}
general.handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'rounded',
        focusable = false,
    }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'rounded',
        silent = true,
        focusable = false,
    }),
}
general.on_attach = function(_, bufnr)
    local goto_opts = {
        float = lsp_utils.float_opts,
    }
    local maps = {
        { { 'n', 'i' }, '<F2>', vim.lsp.buf.rename },
        { 'n', 'K', lsp_utils.hover_or_open_vim_help },
        { 'n', 'gf', vim.lsp.buf.definition },
        { 'n', ']c', function() vim.diagnostic.goto_next(goto_opts) end },
        { 'n', '[c', function() vim.diagnostic.goto_prev(goto_opts) end },
        { 'n', '<C-d>', function() lsp_utils.send_key('<C-d>', bufnr) end },
        { 'n', '<C-u>', function() lsp_utils.send_key('<C-u>', bufnr) end },
        { 'n', '<C-f>', function() lsp_utils.send_key('<C-f>', bufnr) end },
        { 'n', '<C-b>', function() lsp_utils.send_key('<C-b>', bufnr) end },
    }
    utils.set_keymaps(maps, {
        buffer = bufnr,
        silent = true,
    })
    vim.api.nvim_create_augroup('LspConfig', { clear = false })
    utils.create_unique_autocmd({ 'CursorHold' }, {
        group = 'LspConfig',
        buffer = bufnr,
        desc = 'Open diagnostic float',
        callback = function ()
            vim.diagnostic.open_float(vim.tbl_extend('error', {
                scope = 'cursor',
            },
            lsp_utils.float_opts))
        end,
    })
end

local function setup_server(server, opts)
    server:setup(vim.tbl_deep_extend('force', general, {
        capabilities = lsp_utils.get_nvim_lsp_capabilities(),
    }, opts or {}))
end

local servers = {}
servers.rust_analyzer = function(server)
    local opts = {}
    opts.tools = {
        autoSetHints = true,
        hover_with_actions = false,
        inlay_hints = {
            show_parameter_hints = false,
            show_variable_name = true,
            other_hints_prefix = '->',
        },
    }
    opts.server = vim.tbl_deep_extend('force', server:get_default_options(), general, {
        standalone = true,
        capabilities = lsp_utils.get_nvim_lsp_capabilities(),
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = 'clippy',
                },
            },
        },
    })
    require 'rust-tools'.setup(opts)
    server:attach_buffers()
end

servers.sumneko_lua = function(server)
    local opts = require('lua-dev').setup({
        runtime_path = true,
        lspconfig = vim.tbl_deep_extend('force', general, {
            capabilities = lsp_utils.get_nvim_lsp_capabilities(),
            settings = {
                Lua = {
                    hover = {
                        previewFields = 100,
                    },
                    completion = {
                        requireSeparator = '/',
                    },
                },
            },
        })
    })
    local libraries = {}
    for _, value in ipairs(vim.api.nvim_get_runtime_file('lua/', true)) do
        libraries[value] = true
    end
    opts.settings.Lua.workspace.library = vim.tbl_deep_extend(
        'keep',
        opts.settings.Lua.workspace.library,
        libraries
    )
    server:setup(opts)
end

servers.tsserver = function(server)
    local opts = {}
    opts.on_attach = function(client, bufnr)
        lsp_utils.set_document_formatting(client, false)
        general.on_attach(client, bufnr)
    end
    setup_server(server, opts)
end

servers['null-ls'] = function(server)
    local opts = {}
    opts.on_attach = function(_, bufnr)
        local namespaces = vim.tbl_map(function(source)
            return require 'null-ls/diagnostics'.get_namespace(source.id)
        end, require'null-ls'.get_source())
        for _, namespace in ipairs(namespaces) do
            local goto_opts = {
                namespace = namespace,
                float_opts = lsp_uitls.float_opts,
            }
            local maps = {
                { 'n', ']a', function() vim.diagnostic.goto_next(goto_opts) end },
                { 'n', '[a', function() vim.diagnostic.goto_prev(goto_opts) end },
            }
            diagnostic.ignore_signs(namespace)
            utils.set_keymaps(maps, {
                buffer = bufnr,
                silent = true,
            })
        end
    end
    setup_server(server, opts)
end

setmetatable(servers, {
    __index = function(_, _)
        return function(server)
            setup_server(server)
        end
    end
})

function M.setup()
    require 'nvim-lsp-installer'.on_server_ready(function(server)
        servers[server.name](server)
    end)
end

M.general = general

return M
