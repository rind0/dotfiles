if empty($XDG_CONFIG_HOME)
    const g:plugins_dir = $HOME . '/.config/nvim/plugins'
elseif
    const g:plugins_dir = $XDG_CONFIG_HOME . '/nvim/plugins'
endif

const s:cache_dir = empty($XDG_CACHE_HOME) ? expand($HOME . '/.cache') : $XDG_CACHE_HOME
const s:dein_dir = s:cache_dir . '/dein'
const s:dein_core_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_core_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_core_dir))
endif

if has('vim_starting')
    let &runtimepath = s:dein_core_dir .",". &runtimepath
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(g:plugins_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(g:plugins_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#load_toml(g:plugins_dir . '/dein_ddc.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

if has('win32') || has('win64')
    const g:python3_host_prog = $HOME . '/scoop/shims/python3'
    const g:node_hodt_prog    = $HOME . '/scoop/apps/yarn/current/global/bin/neovim-node-host'
endif

runtime! userautoload/*.vim
