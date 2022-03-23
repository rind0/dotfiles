" 画面表示の設定
set number                  " 行番号
set relativenumber          " 相対行番号
set title                   " ファイル名の表示
syntax on                   " 構文ハイライト

" タブ/インデント設定
set autoindent              " 自動インデント
set expandtab               " 入力モードでTab押下時に半角スペースを挿入
set shiftwidth=4            " インデント幅
set tabstop=4               " タブの行事幅

" ファイル処理関連設定
set autoread                " 外部でファイルが変更された場合は読み直す
set hidden                  " 保存されていないファイルがある時でも別のファイルを開くことができる
set nobackup                " ファイル保存時にバックアップファイルを作らない
set noswapfile              " ファイル編集中にスワップファイルを作らない
filetype plugin indent on   " ファイルタイプの自動検出とプラグインとインデント設定の自動読み込み
