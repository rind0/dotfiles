local telescope_result, telescope = pcall(require, 'telescope')
if not telescope_result then
	return
end
telescope.setup {
	defaults = {
		prompt_prefix = '>',
		path_display = { 'smart' },
	}
}
