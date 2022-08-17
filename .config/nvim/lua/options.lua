vim.cmd('language en_US.UTF-8')
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.title = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.encoding = 'utf-8'
vim.cmd('filetype plugin indent on')

local function set_highlight(name, opt)
	local cmd = {}
	table.insert(cmd, 'highlight')
	table.insert(cmd, name)
	for k, v in pairs(opt) do
		table.insert(cmd, k .. '=' .. v)
	end
	vim.cmd(table.concat(cmd, ' '))
end
set_highlight('Normal', { ctermbg = NONE, guibg = NONE })
set_highlight('NonText', { ctermfg = NONE, ctermbg = NONE, guifg = NONE, guibg = NONE })

require 'autocommands'
require 'colorscheme'
require 'mappings'
