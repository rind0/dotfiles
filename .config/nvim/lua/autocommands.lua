local function number_in_visual()
	local mode = vim.fn.mode()
	print(mode)
	--if mode == 'v' or mode == 'V' then
	--	vim.wo.number = true
	--	vim.wo.relativenumber = true
	--end
	--if mode == 'n' or mode == 'V' then
	--	vim.wo.number = false
	--	vim.wo.relativenumber = false
	--end
end
--local group = vim.api.nvim_create_augroup('number_in_visual', {})
--vim.api.nvim_create_autocmd('ModeChanged', {
--	group = group,
--	callback = number_in_visual
--})
vim.cmd[[
augroup number_in_visual
    autocmd!
    autocmd ModeChanged [vV\x16]*:* let &l:rnu = mode() =~# '^[vV\x16]'
    autocmd ModeChanged *:[vV\x16]* let &l:rnu = mode() =~# '^[vV\x16]'
    autocmd WinEnter,WinLeave * let &l:rnu = mode() =~# '^[vV\x16]'
augroup END
]]

