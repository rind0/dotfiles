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
