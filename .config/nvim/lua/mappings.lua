local utils = require 'utils'

local telescope_ok, telescope = pcall(require, 'telescope.builtin')
if telescope_ok then
	local maps = {
		{ 'n', 'ff', function() telescope.find_files() end },
		{ 'n', 'fg', function() telescope.live_grep() end },
		{ 'n', 'fb', function() telescope.buffers() end },
		{ 'n', 'fh', function() telescope.help_tags() end },
	}
	utils.set_keymaps(maps, {})
end

local maps = {
	{ 'n', '<esc>', '<cmd>noh<return><esc>' }
}
utils.set_keymaps(maps, {})
