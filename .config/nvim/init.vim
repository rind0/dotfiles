" dein
if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let dein_dir = expand('$HOME/.cache/dein')
if dein#load_state(dein_dir)
  call dein#begin(dein_dir)

  let toml_dir = expand('$HOME/.config/nvim')
  call dein#load_toml(toml_dir . '/dein.toml',       {'lazy': 0})
  call dein#load_toml(toml_dir . '/dein_lazy.toml',  {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif

" vimの設定
set encoding=utf-8                    " 文字コード
set title                             " ファイル名の表示
set number                            " 行番号
set autoindent                        " 自動インデント
set expandtab                         " 入力モードでTab押下時に半角スペースを挿入
set tabstop=2                         " タブの行事幅
set shiftwidth=2                      " インデント幅
set clipboard=unnamed                 " ヤンクをクリップボードにコピー
set showmatch                         " 対応する括弧を強調表示
set ignorecase                        " 全て小文字なら大文字小文字の区別をしない
set smartcase                         " 大文字で始まるなら大文字小文字の区別をする
set incsearch                         " 順次検索
set wrapscan                          " ループ
set hlsearch                          " 検索結果をハイライト
nmap <Esc><Esc> :nohlsearch<CR><Esc>  " ハイライト解除

" ハイライトの設定
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
