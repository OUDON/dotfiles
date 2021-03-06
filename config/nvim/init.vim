set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ===========================
"         dein.vim
" ===========================
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('Shougo/neocomplcache.git')
  call dein#add('itchyny/lightline.vim')

  " highlighting
  call dein#add('othree/html5.vim')
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('posva/vim-vue')
  call dein#add('elixir-editors/vim-elixir')
  call dein#add('mrk21/yaml-vim')

  " colorscheme
  call dein#add('jacoborus/tender.vim')

  call dein#end()
  call dein#save_state()
endif


" ===========================
"       neocomplcache
" ===========================
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


augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END

set background=dark
colorscheme tender

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

set nu 
syntax enable
set ts=2 sw=2 sts=2 et  
set is hls ic           
set sm mat=0            
set backspace=indent,eol,start

set undodir=$HOME/.vim/undodir
set undofile

" インデント関係
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent

" 拡張子によってタブ幅を変える
" http://qiita.com/mitsuru793/items/2d464f30bd091f5d0fef
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py  setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.h   setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.hpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.c   setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFIle,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" シンタックス
autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby

" テンプレート
autocmd BufNewFile *.cpp 0r $HOME/.vim/template/cpp.txt

" コメントアウトを継続しない
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=r
	autocmd BufEnter * setlocal formatoptions-=o
augroup END

" クリップボード連携
set clipboard+=unnamed

" エンコーディング
set fileencodings=utf-8,sjis,euc-jp

" ステータスライン
set laststatus=2
let g:lightline = {
    \ 'colorscheme' : 'wombat'
    \ }

set termguicolors
