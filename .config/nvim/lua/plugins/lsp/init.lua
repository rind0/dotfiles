vim.lsp.stop_client(vim.lsp.get_active_clients())
require 'plugins/lsp/install'.install({
    'rust_analyzer',
    'sumneko_lua',
    'tsserver',
})
require 'plugins/lsp/servers'.setup()
