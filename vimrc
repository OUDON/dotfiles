augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END

" プラグイン
set nocompatible
filetype off            " for NeoBundle
 
if has('vim_starting')
        set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
 
" NeoBundle で管理するプラグインを追加します。
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'othree/html5.vim'

NeoBundleLazy 'vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ }
call neobundle#end()
 
filetype plugin indent on       " restore filetype

" neocomplcache
"neocomplcache を有効にする
let g:neocomplcache_enable_at_startup = 1
"neocomplcache の smart case 機能を有効にする
let g:neocomplcache_enable_smart_case = 1
"neocomplcache の camel case 機能を有効にする
let g:neocomplcache_enable_camel_case_completion = 1
"_区切りの補完を有効にする
let g:neocomplcache_enable_underbar_completion = 1
"シンタックスをキャッシュするときの最小文字長を設定する
let g:neocomplcache_min_syntax_length = 5
" 補完候補の選択にtabを使う
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

set nu 
syntax on
filetype plugin indent on
set ts=2 sw=2 sts=2 et  
set is hls ic           
set sm mat=0            
set backspace=indent,eol,start

set undodir=$HOME/.vim/undodir
set undofile

" インデント関係
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent

" 拡張子によってタブ幅を変える
" http://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFIle,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" テンプレート
autocmd BufNewFile *.cpp 0r $HOME/.vim/template/cpp.txt


" クリップボード連携
set clipboard+=unnamed

" エンコーディング
set fileencodings=utf-8,sjis,euc-jp
