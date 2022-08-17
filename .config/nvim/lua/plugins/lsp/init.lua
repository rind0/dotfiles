vim.lsp.stop_client(vim.lsp.get_active_clients())
require 'mason'.setup()
require 'mason-lspconfig'.setup()
require 'plugins.lsp.servers'
require 'plugins.lsp.signature'
