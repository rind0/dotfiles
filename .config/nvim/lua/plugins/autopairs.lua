local npairs_ok, npairs = pcall(require, 'nvim-autopairs')
if not npairs_ok then
	return
end
npairs.setup({
	disable_filetype = { 'TelescopePrompt', 'vim' },
	fast_wrap = {
		chars = { '(', '[', '{', '"', "'", '`' },
	},
})
local rule = require 'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'
npairs.add_rules {
	rule(' ', ' ')
		:with_pair(function(opts)
			local pair = opts.line:sub(opts.col -1, opts.col)
			return vim.tbl_contains({ '()', '[]', '{}' }, pair)
		end)
		:with_move(cond.none())
		:with_cr(cond.none())
		:with_del(function(opts)
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local context = opts.line:sub(col - 1, col + 2)
			return vim.tbl_contains({ '( )', '[ ]', '{ }' }, context)
		end),
	rule('', ' )')
		:with_pair(cond.none())
    	:with_move(function(opts) return opts.char == ')' end)
    	:with_cr(cond.none())
    	:with_del(cond.none())
    	:use_key(')'),
	rule('', ' ]')
		:with_pair(cond.none())
    	:with_move(function(opts) return opts.char == ']' end)
    	:with_cr(cond.none())
    	:with_del(cond.none())
    	:use_key(']'),
	rule('', ' }')
		:with_pair(cond.none())
    	:with_move(function(opts) return opts.char == '}' end)
    	:with_cr(cond.none())
    	:with_del(cond.none())
    	:use_key('}'),
	--rule("'''", "'''", { 'toml' }),
	--rule(' ', ' ')
	--	:with_pair(function(opts)
	--		local pair = opts.line:sub(opts.col - 1, opts.col)
	--		return vim.tbl_contains({ '()', '[]', '{}' }, pair)
	--	end),
}

--local cmp_npairs = require 'nvim-autopairs.completion.cmp'
--local cmp_ok, cmp = pcall(require, 'cmp')
--if not cmp_ok then
--	return
--end
--cmp.event:on('confirm_done', cmp_npairs.on_confirm_done { map_char = { tex = '' } })
