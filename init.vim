"�s�ԍ���\��
set number
"�^�u�����̑���ɃX�y�[�X���g��
set expandtab
"�v���O���~���O����ɍ��킹�ēK�؂ɃC���f���g�������}��
set smartindent
"�e�R�}���h��smartindent�ő}������󔒂̗�
set shiftwidth=4
"Tab�L�[�ő}������X�y�[�X�̐�
set softtabstop=4
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
    Myterm
endif

"��̃G�f�B�^�E�B���h�E�Ɖ��̃^�[�~�i���E�B���h�E(�^�[�~�i���}�����[�h)���s����
tnoremap <C-t> <C-\><C-n><C-w>k
nnoremap <C-t> <C-w>ji
"�^�[�~�i���}�����[�h����^�[�~�i�����[�h�ֈȍ~
tnoremap <Esc> <C-\><C-n>

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

" esc�������̂ő�p����B
"noremap <C-j> <esc>
noremap! <C-j> <esc>
"
nnoremap <C-j> <pagedown>
nnoremap <C-k> <pageup>

nnoremap <silent> <TAB><TAB> :tabn<CR>