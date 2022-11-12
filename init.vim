
"行番号を表示
set number
"タブ文字の代わりにスペースを使う
set expandtab
"プログラミング言語に合わせて適切にインデントを自動挿入
set smartindent
"各コマンドやsmartindentで挿入する空白の量
set shiftwidth=2
"Tabキーで挿入するスペースの数
set softtabstop=2
"カレントディレクトリを自動で移動
set autochdir
"バッファ内で扱う文字コード
set encoding=utf-8
"書き込む文字コード : この場合encodingと同じなので省略可
set fileencoding=utf-8
"読み込む文字コード : この場合UTF-8を試し、だめならShift_JIS
set fileencodings=utf-8,cp932
"Vimの無名レジスタとシステムのクリップボードを連携 : ダメならxclipをインストールで使えるかも
set clipboard+=unnamed,unnamedplus
"eコマンド等でTabキーを押すとパスを保管する : この場合まず最長一致文字列まで補完し、2回目以降は一つづつ試す
set wildmode=longest,full
"LeaderキーをSpaceに設定(これだけでは意味をなさない)
let mapleader = "\<Space>"
"C++,Java等のインラインブロックを中括弧付きのブロックに展開
nnoremap <C-j> ^/(<CR>%a{<CR><Esc>o}<Esc>
"カーソル上の単語を置換
nnoremap <expr> S* ':%s/\<' . expand('<cword>') . '\>/'

"挿入モード終了時にIMEをオフ
inoremap <silent> <Esc> <Esc>:call system('fcitx-remote -c')<CR>
"下部分にターミナルウィンドウを作る
function! Myterm()
    split
    wincmd j
    resize 10
    terminal
    wincmd k
endfunction
command! Myterm call Myterm()

"起動時にターミナルウィンドウを設置
if has('vim_starting')
"    Myterm
endif

" "上のエディタウィンドウと下のターミナルウィンドウ(ターミナル挿入モード)を行き来
" tnoremap <C-t> <C-\><C-n><C-w>k
" nnoremap <C-t> <C-w>ji
" "ターミナル挿入モードからターミナルモードへ以降
" tnoremap <Esc> <C-\><C-n>

"ファイルタイプごとにコンパイル/実行コマンドを定義
function! Setup()
    "フルパスから拡張子を除いたもの
    let l:no_ext_path = printf("%s/%s", expand("%:h"), expand("%:r"))
    "各言語の実行コマンド
    let g:compile_command_dict = {
                \'c': printf('gcc -std=gnu11 -O2 -lm -o %s.out %s && %s/%s.out', expand("%:r"), expand("%:p"), expand("%:h"), expand("%:r")),
                \'cpp': printf('g++ -std=gnu++17 -O2 -o %s.out %s && %s/%s.out', expand("%:r"), expand("%:p"), expand("%:h"), expand("%:r")),
                \'java': printf('javac %s && java %s', expand("%:p"), expand("%:r")),
                \'cs': printf('mcs -r:System.Numerics -langversion:latest %s && mono %s/%s.exe', expand("%:p"), expand("%:h"), expand("%:r")),
                \'python': printf('python3 %s', expand("%:p")),
                \'ruby': printf('ruby %s', expand("%:p")),
                \'javascript': printf('node %s', expand("%:p")),
                \'sh': printf('chmod u+x %s && %s', expand("%:p"), expand("%:p"))
                \}
    "実行コマンド辞書に入ってたら実行キーバインドを設定
    if match(keys(g:compile_command_dict), &filetype) >= 0
        "下ウィンドウがターミナルであることを前提としている
        nnoremap <expr> <F5> '<C-w>ji<C-u>' . g:compile_command_dict[&filetype] . '<CR>'
    endif
endfunction
command! Setup call Setup()

"ファイルを開き直したときに実行コマンドを再設定
autocmd BufNewFile,BufRead * Setup
"RubyとJSではインデントを2マスにする
autocmd FileType ruby,javascript set shiftwidth=2 softtabstop=2


" mysetting ####################################################################
" Save Folding
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" MAP
" 削除でレジスタに格納しない(ビジュアルモードでの選択後は格納する)
nnoremap x "_x
nnoremap dd "_dd
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
"カーソル下の単語をハイライトする
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
" ハイライトを消去する
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" grep移動
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

" 複数行を移動
vnoremap <C-k> "zx<UP>"zP`[V`]
vnoremap <C-j> "zx"zp`[V`]

noremap! <C-j> <esc>
nnoremap <C-j> <pagedown>
nnoremap <C-k> <pageup>
nnoremap <silent> <TAB><TAB> :tabn<CR>

cnoremap init :<C-u>edit $MYVIMRC<CR>
cnoremap cheat :<C-u>edit $MYVIMRC<CR>

" plugin map
map <C-n> :NERDTreeToggle<CR>
" QuickHl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
" lightline
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
" molokai
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
" Yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
" nmap <C-p> <Plug>(yankround-prev)
" nmap <C-n> <Plug>(yankround-next)


"// PLUGIN SETTINGS ///////////////////////////////////////////////////
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'bronson/vim-trailing-whitespace'
Plug 't9md/vim-quickhl'
Plug 'tomasr/molokai'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'LeafCage/yankround.vim'
Plug 'rhysd/accelerated-jk'
Plug 'tomtom/tcomment_vim'
Plug 'anuvyklack/pretty-fold.nvim'

" javascrfipt
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }

call plug#end()

" NERDTree ---------------
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '?'
let g:NERDTreeDirArrowCollapsible = '▼'

" Airline SETTINGS
let g:airline_powerline_fonts = 1
"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none
" INDENT_GUIDES
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 2
" 無効にしたいファイルタイプがある場合は以下のような設定を追加。
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
" 可視化領域のサイズを変更したい場合は以下のような設定を追加
let g:indent_guides_guide_size = 1
" 可視化を行う階層を指定する場合は以下のような設定を追加。デフォルトの値は1。
let g:indent_guides_start_level = 1
" tigris
let g:tigris#enabled = 1
let g:tigris#on_the_fly_enabled = 1
let g:tigris#delay = 300









