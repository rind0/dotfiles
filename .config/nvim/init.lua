local api = vim.api
api.nvim_set_var('dein#enable_notification', 1)
api.nvim_set_var('dein#install_max_processes', 16)
api.nvim_set_var('dein#install_message_type', 'none')
api.nvim_set_var('dein#enable_notification', 1)
api.nvim_set_var('dein#install_github_api_token', '$DEIN_GITHUB_TOKEN')

local dein_dir = vim.fn.expand('$XDG_CACHE_HOME/dein')
local dein_repo_dir = dein_dir..'repos/github.com/Shougo/dein.vim'
if not string.match(vim.o.runtimepath, '/dein.vim') then
	if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
		local cmd_str = 'git clone https://github.com/Shougo/dein.vim'
		os.execute(cmd_str..' '..dein_repo_dir)
		print(cmd_str..dein_repo_dir)
	end
	vim.o.runtimepath = dein_repo_dir..','..vim.o.runtimepath
end

if vim.call('dein#load_state', dein_dir) == 1 then
	vim.call('dein#begin', dein_dir)
	local files = vim.fn.glob('$XDG_CONFIG_HOME/nvim/plugins/**/*.toml', 0, 1)
	for i, v in ipairs(files) do
		vim.call('dein#load_toml', v)
	end
	vim.call('dein#end')
	vim.call('dein#save_state')
end

if vim.call('dein#check_install') ~= 0 then
	vim.call('dein#install')
end

local removed_plugins = vim.call('dein#check_clean')
if vim.fn.len(removed_plugins) > 0 then
	vim.fn.map(removed_plugins, "delete(v:val, 'rf')")
	vim.call('dein#recache_runtimepath')
end

require 'options'
