local lsp_utils = require 'plugins.lsp.utils'

local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = lsp_utils.get_cmp_nvim_lsp_capabilities(),
}
local lspconfig = require 'lspconfig'
lspconfig.util.default_config = vim.tbl_deep_extend(
	'force',
	lspconfig.util.default_config,
	lsp_defaults
)

lspconfig.rust_analyzer.setup {
}
lspconfig.sumneko_lua.setup {
	settings = {
		Lua = {
			hover = {
				previewFields = 100,
			},
			completion = {
				requireSeparator = '/',
			},
		},
		diagnostics = {
			globals = { 'P' },
		},
	}
}
local null_ls = require 'null-ls'
null_ls.setup {
	on_attach = function(_, bufnr)
		local namespaces = vim.tbl_map(function(source)
            return require 'null-ls.diagnostics'.get_namespace(source.id)
        end, null_ls.get_source())
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
}
