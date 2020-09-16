" deinのインストールディレクトリをruntimepathに追加
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let dein_dir = expand('$HOME/.cache/dein')
if dein#load_state(dein_dir)
  call dein#begin(dein_dir)

  let toml_dir = expand('$HOME/dotfiles/.config/nvim/plugins')
  call dein#load_toml(toml_dir . '/dein.toml',       {'lazy': 0})
  call dein#load_toml(toml_dir . '/dein_lazy.toml',  {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif
