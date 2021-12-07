" deinの自動インストール
let s:cache_home    = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let s:dein_dir      = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" deinのインストールディレクトリをruntimepathに追加
if has('vim_starting')
    let &runtimepath = s:dein_repo_dir .",". &runtimepath
endif

" プラグインの読み込み
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_dir = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config/nvim/plugins') : $XDG_CONFIG_HOME . '/nvim/plugins'
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#load_toml(s:toml_dir . '/dein_ddc.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif
