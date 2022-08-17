local utils = require 'utils'

local sources = {
    'nvim-lsp',
    'buffer',
    'around',
}
vim.fn['ddc#custom#patch_global']('sources', sources)
local source_opts = {}
source_opts['_'] = {
    ['matchers'] = { 'matcher_fuzzy' },
    ['sorters'] = { 'sorter_fuzzy' },
    ['converters'] = { 'converter_truncate', 'converter_remove_overlap', 'converter_fuzzy' },
    ['ignoreCase'] = true,
}
source_opts['around'] = {
    ['mark'] = 'A',
}
source_opts['buffer'] = {
    ['mark'] = 'B',
    ['maxCandidates'] = 10,
    ['ignoreCase'] = true,
}
source_opts['nvim-lsp'] = {
    ['mark'] = 'LSP',
    ['forceCompletionPattern'] = "\\.|:\\s*|->",
    ['ignoreCase'] = true,
}
vim.fn['ddc#custom#patch_global']('sourceOptions', source_opts)

local source_params = {}
source_params['around'] = {
    ['maxSize'] = 500,
}
source_params['buffer'] = {
    ['fromAltBuf'] = true,
    ['forceCollect'] = true,
    ['showBufName'] = true,
}
vim.fn['ddc#custom#patch_global']('sourceParams', source_params)

local filter_params = {}
filter_params['matcher_fuzzy'] = {
    ['splitMode'] = 'word',
}
filter_params['converter_truncate'] = {
    ['maxAbbrWidth'] = 60,
    ['maxInfo'] = 500,
    ['ellipsis'] = '...',
}
vim.fn['ddc#custom#patch_global']('filterParams', filter_params)

vim.fn['ddc#custom#patch_global']('specialBufferCompletion', true)
vim.fn['ddc#custom#patch_global']('completionMenu', 'pum.vim')
local maps = {
    { 'n', '<S-Tab>', '<Cmd>call pum#map#insert_relative(+1)<CR>', { inoremap = true } },
    { 'n', '<C-n>', '<Cmd>call pum#map#select_relative(+1)<CR>', { inoremap = true } },
    { 'n', '<C-p>', '<Cmd>call pum#map#select_relative(-1)<CR>', { inoremap = true } },
    { 'n', '<C-y>', '<Cmd>call pum#map#confirm()<CR>', { inoremap = true } },
    { 'n', '<C-e>', '<Cmd>call pum#map#cancel()<CR>', { inoremap = true } },
}
utils.set_keymaps(maps)
vim.fn['ddc#enable']()
