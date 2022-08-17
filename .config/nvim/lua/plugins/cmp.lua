vim.o.completeopt = 'menuone,noselect'
local cmp = require 'cmp'
local opts = {
	snippet = {
		expand = function(args)
			local luasnip_ok, luasnip = pcall(require, 'luasnip')
			if luasnip_ok then
				luasnip.lsp_expand(args.body)
			end
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.close(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				buffer = '[Buffer]',
				nvim_lsp = '[LSP]',
				path = '[Path]',
			})[entry.source.name]
			return vim_item
		end,
	},
}
cmp.setup(opts)
