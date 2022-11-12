
"�s�ԍ���\��
set number
"�^�u�����̑���ɃX�y�[�X���g��
set expandtab
"�v���O���~���O����ɍ��킹�ēK�؂ɃC���f���g�������}��
set smartindent
"�e�R�}���h��smartindent�ő}������󔒂̗�
set shiftwidth=2
"Tab�L�[�ő}������X�y�[�X�̐�
set softtabstop=2
"�J�����g�f�B���N�g���������ňړ�
set autochdir
"�o�b�t�@���ň��������R�[�h
set encoding=utf-8
"�������ޕ����R�[�h : ���̏ꍇencoding�Ɠ����Ȃ̂ŏȗ���
set fileencoding=utf-8
"�ǂݍ��ޕ����R�[�h : ���̏ꍇUTF-8�������A���߂Ȃ�Shift_JIS
set fileencodings=utf-8,cp932
"Vim�̖������W�X�^�ƃV�X�e���̃N���b�v�{�[�h��A�g : �_���Ȃ�xclip���C���X�g�[���Ŏg���邩��
set clipboard+=unnamed,unnamedplus
"e�R�}���h����Tab�L�[�������ƃp�X��ۊǂ��� : ���̏ꍇ�܂��Œ���v������܂ŕ⊮���A2��ڈȍ~�͈�Â���
set wildmode=longest,full
"Leader�L�[��Space�ɐݒ�(���ꂾ���ł͈Ӗ����Ȃ��Ȃ�)
let mapleader = "\<Space>"
"C++,Java���̃C�����C���u���b�N�𒆊��ʕt���̃u���b�N�ɓW�J
nnoremap <C-j> ^/(<CR>%a{<CR><Esc>o}<Esc>
"�J�[�\����̒P���u��
nnoremap <expr> S* ':%s/\<' . expand('<cword>') . '\>/'

"�}�����[�h�I������IME���I�t
inoremap <silent> <Esc> <Esc>:call system('fcitx-remote -c')<CR>
"�������Ƀ^�[�~�i���E�B���h�E�����
function! Myterm()
    split
    wincmd j
    resize 10
    terminal
    wincmd k
endfunction
command! Myterm call Myterm()

"�N�����Ƀ^�[�~�i���E�B���h�E��ݒu
if has('vim_starting')
"    Myterm
endif

" "��̃G�f�B�^�E�B���h�E�Ɖ��̃^�[�~�i���E�B���h�E(�^�[�~�i���}�����[�h)���s����
" tnoremap <C-t> <C-\><C-n><C-w>k
" nnoremap <C-t> <C-w>ji
" "�^�[�~�i���}�����[�h����^�[�~�i�����[�h�ֈȍ~
" tnoremap <Esc> <C-\><C-n>

"�t�@�C���^�C�v���ƂɃR���p�C��/���s�R�}���h���`
function! Setup()
    "�t���p�X����g���q������������
    let l:no_ext_path = printf("%s/%s", expand("%:h"), expand("%:r"))
    "�e����̎��s�R�}���h
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
    "���s�R�}���h�����ɓ����Ă�����s�L�[�o�C���h��ݒ�
    if match(keys(g:compile_command_dict), &filetype) >= 0
        "���E�B���h�E���^�[�~�i���ł��邱�Ƃ�O��Ƃ��Ă���
        nnoremap <expr> <F5> '<C-w>ji<C-u>' . g:compile_command_dict[&filetype] . '<CR>'
    endif
endfunction
command! Setup call Setup()

"�t�@�C�����J���������Ƃ��Ɏ��s�R�}���h���Đݒ�
autocmd BufNewFile,BufRead * Setup
"Ruby��JS�ł̓C���f���g��2�}�X�ɂ���
autocmd FileType ruby,javascript set shiftwidth=2 softtabstop=2


" mysetting ####################################################################
" Save Folding
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" MAP
" �폜�Ń��W�X�^�Ɋi�[���Ȃ�(�r�W���A�����[�h�ł̑I����͊i�[����)
nnoremap x "_x
nnoremap dd "_dd
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
"�J�[�\�����̒P����n�C���C�g����
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
" �n�C���C�g����������
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" grep�ړ�
nnoremap [q :cprevious<CR>   " �O��
nnoremap ]q :cnext<CR>       " ����
nnoremap [Q :<C-u>cfirst<CR> " �ŏ���
nnoremap ]Q :<C-u>clast<CR>  " �Ō��

" �����s���ړ�
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
let g:NERDTreeDirArrowCollapsible = '��'

" Airline SETTINGS
let g:airline_powerline_fonts = 1
"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none
" INDENT_GUIDES
" vim�𗧂��グ���Ƃ��ɁA�����I��vim-indent-guides���I���ɂ���
let g:indent_guides_enable_on_vim_startup = 2
" �����ɂ������t�@�C���^�C�v������ꍇ�͈ȉ��̂悤�Ȑݒ��ǉ��B
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
" �����̈�̃T�C�Y��ύX�������ꍇ�͈ȉ��̂悤�Ȑݒ��ǉ�
let g:indent_guides_guide_size = 1
" �������s���K�w���w�肷��ꍇ�͈ȉ��̂悤�Ȑݒ��ǉ��B�f�t�H���g�̒l��1�B
let g:indent_guides_start_level = 1
" tigris
let g:tigris#enabled = 1
let g:tigris#on_the_fly_enabled = 1
let g:tigris#delay = 300









