function! s:init_pum() abort
    if v:true
        call ddc#custom#patch_global('completionMenu', 'pum.vim')
    
        inoremap <silent><expr> <TAB>
            \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
            \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
            \ '<TAB>' : ddc#manual_complete()
        inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
        inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
        inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
        inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    
        call pum#set_option('setline_insert', v:false)
        " autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
    else
        call ddc#set_option('setline_insert', 'native')
        inoremap <silent><expr> <TAB>
            \ pumvisible() ? '<C-n>' :
            \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
            \ '<TAB>' : ddc#manual_complete()
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    endif
endfunction

function! s:init_ddc() abort
    call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_fuzzy'],
        \   'sorters': ['sorter_fuzzy'],
        \   'converters': ['converter_truncate', 'converter_remove_overlap', 'converter_fuzzy'],
        \   'ignoreCase': v:true,
        \ }})
    call ddc#custom#patch_global('filterParams', {
        \ 'matcher_fuzzy': {
        \   'splitMode': 'word',
        \ },
        \ 'converter_truncate': {
        \   'maxAbbrWidth': 60,
        \   'maxInfo': 500,
        \   'ellipsis': '...',
        \ }})
endfunction

function! s:add_around_source(sources) abort
    let new_sources = a:sources
    call ddc#custom#patch_global('sourceOptions', {
        \ 'around': {
        \   'mark': 'A',
        \   }})
    call ddc#custom#patch_global('sourceParams', {
        \ 'around': {
        \   'maxSize': 500,
        \ }})
    let new_sources += ['around']
    return new_sources
endfunction

function! s:add_buffer_source(sources) abort
    let new_sources = a:sources
    call ddc#custom#patch_global('sourceOptions', {
        \ 'buffer': {
        \   'mark': 'B',
        \   'maxCandidates': 10,
        \   'ignoreCase': v:true,
        \ }})
    call ddc#custom#patch_global('sourceParams', {
        \ 'buffer': {
        \   'fromAltBuf': v:true,
        \   'forceCollect': v:true,
        \   'showBufName': v:true,
        \ }})
    let new_sources += ['buffer']
    return new_sources
endfunction

function! s:add_file_source(sources) abort
    let new_sources = a:sources
    call ddc#custom#patch_global('sourceOptions', {
        \ 'file': {
        \   'mark': 'F',
        \   'isVolatile': v:true,
        \   'forceCompletionPattern': '\S/\S*',
        \ }})
    let new_sources += ['file']
    return new_sources
endfunction

function! s:add_lsp_source(sources)
    let new_sources = a:sources
    if has('nvim')
        call ddc#custom#patch_global('sourceOptions', {
            \ 'nvim-lsp': {
            \   'mark': 'lsp',
            \   'forceCompletionPattern': "\\.|:\\s*|->",
            \   'ignoreCase': v:true,
            \ }})
        let new_sources += ['nvim-lsp']
    else
        call ddc#custom#patch_global('sourceOptions', {
            \ 'vim-lsp': {
            \   'mark': 'lsp',
            \   'forceCompletionPattern': "\\.|:\\s*|->",
            \   'ignoreCase': v:true,
            \ }})
        let new_sources += ['vim-lsp']
    endif
    return new_sources
endfunction

function! s:add_vsnip_source(sources) abort
    let new_sources = a:sources
    call ddc#custom#patch_global('sourceOptions', {
        \ 'vsnip': {
        \   'dup': v:true,
        \ }})
    let new_sources += ['vsnip']
    return new_sources
endfunction

call s:init_pum()
call s:init_ddc()

let s:sources = []
let s:sources = s:add_lsp_source(s:sources)
let s:sources = s:add_buffer_source(s:sources)
let s:sources = s:add_vsnip_source(s:sources)
let s:sources = s:add_around_source(s:sources)
let s:sources = s:add_file_source(s:sources)

call ddc#custom#patch_global('specialBufferCompletion', v:true)
call ddc#custom#patch_global('sources', s:sources)

call ddc#custom#patch_filetype(['vim', 'toml'], {
    \ 'sources': ['buffer', 'around', 'vsnip', 'file']
    \ })

call ddc#enable()
