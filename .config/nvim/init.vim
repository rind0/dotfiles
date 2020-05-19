" dein
if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let dein_dir = expand('$HOME/.cache/dein')
if dein#load_state(dein_dir)
  call dein#begin(dein_dir)

  let toml_dir = expand('$HOME/dotfiles/.config/nvim')
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

" Vimの設定
" 画面表示の設定
set number                            " 行番号
set title                             " ファイル名の表示

" タブ/インデント設定
set autoindent                        " 自動インデント
set expandtab                         " 入力モードでTab押下時に半角スペースを挿入
set shiftwidth=4                      " インデント幅
set tabstop=4                         " タブの行事幅

" ファイル処理関連設定
set autoread                          " 外部でファイルが変更された場合は読み直す
set hidden                            " 保存されていないファイルがある時でも別のファイルを開くことができる
set nobackup                          " ファイル保存時にバックアップファイルを作らない
set noswapfile                        " ファイル編集中にスワップファイルを作らない

" ハイライト設定
set hlsearch                          " 検索結果をハイライト
set ignorecase                        " 全て小文字なら大文字小文字の区別をしない
set incsearch                         " 順次検索
set showmatch                         " 対応する括弧を強調表示
set smartcase                         " 大文字で始まるなら大文字小文字の区別をする
set wrapscan                          " ループ
nmap <Esc><Esc> :nohlsearch<CR><Esc>  " ハイライト解除

highlight Normal      ctermbg=NONE guibg=NONE
highlight NonText     ctermbg=NONE guibg=NONE
highlight LineNr      ctermbg=NONE guibg=NONE
highlight SpecialKey  ctermbg=NONE guibg=NONE
highlight Folded      ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE

" 環境設定
set clipboard=unnamed,unnamedplus     " ヤンクをクリップボードにコピー
set encoding=utf-8                    " 文字コード
set mouse=a                           " マウスの入力を受け付ける
set shellslash                        " Windowsでもパスの区切りを/にする
