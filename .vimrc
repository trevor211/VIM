""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 基本配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set number "设置行号
set relativenumber "设置相对行号
set cc=81 "高亮第81列
filetype plugin indent on
syntax on
set tabstop=4                   " tab width
set shiftwidth=4
set softtabstop=4               " 按退格键时可以一次删掉4个空格
set expandtab                   " 如果此时需要输入真正的tab，则输入Ctrl+V, tab，在windows下是Ctrl+Q, tab
set showcmd                     " 输入的命令显示出来，看的清楚些
set cursorline
set wildmenu
set hlsearch                    " hightlight search results
set incsearch                   " match results in realtime after typein new char
set fencs=utf-8,gbk,ucs-bom,gb18030,iso-8859-15
set vb t_vb=                    " cancel error bell
set linebreak
set whichwrap=b,s,<,>,[,]       " move cursor to another line when in head or tail
set list                        " list tab
set listchars=tab:»·,trail:·    " tab '»···', Blank at tail '·'
set autochdir                   " change dir to current file's dir
set hidden                      " hide unsaved buffer
set scrolloff=5                 " 光标移动到buffer的顶部和底部时保持x行距离
set ruler
set showmatch                   " 设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set smartindent                 " 智能对齐方式
set autoindent                  " 自动对齐
set ai!                         " 设置自动缩进
set textwidth=0


let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

if has('statusline')
	set laststatus=2
	set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} "状态行显示的内容
endif
set backspace=2                 " enable backspace

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"记忆文件关闭时光标位置
if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
            \ 'coc-marketplace',
            \ 'coc-format-json',
            \ 'coc-ccls',
            \ 'coc-vimlsp',
            \ 'coc-json'
            \]
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'      "配色
Plug 'scrooloose/syntastic'

" 用于模糊查找文件或者函数,取代ctrlp与ctrlp-funky
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'vim-scripts/taglist.vim'
Plug 'dkprice/vim-easygrep'
Plug 'kshenoy/vim-signature'
Plug 'hari-rangarajan/cctree'

Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'derekwyatt/vim-fswitch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/AutoComplPop'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Plug 'morhetz/gruvbox'
colorscheme gruvbox
set background=dark

" Yggdroot/LeaderF
" Ctrl + p 打开文件搜索
let s:project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:Lf_ShortcutF = '<c-p>'
"\p 打开函数列表
noremap <Leader>p :LeaderfFunction<cr>
let g:Lf_RootMarker = s:project_root
let g:Lf_WorkingDirectoryMode = 'A'
let g:Lf_UseVersionControlTool = 0

" Tags
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" skywind3000/vim-preview
" 预览 quickfix 窗口 ctrl-w z 关闭
" P 预览 大p关闭
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
noremap <Leader>u :PreviewScroll -1<cr> " 往上滚动预览窗口
noremap <leader>d :PreviewScroll +1<cr> "  往下滚动预览窗口

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

" Plug 'majutsushi/tagbar'
nmap <Space>e :TagbarToggle<CR>

" Plug 'scrooloose/nerdtree'
map <Space>w :NERDTreeToggle<CR>
nnoremap <F2> :NERDTreeFind<CR>

"derekwyatt/vim-fswitch
nnoremap <Space>r :FSHere<CR>
augroup mycppfiles
  au!
  au BufEnter *.h let b:fswitchdst  = 'cpp,cc,C'
  au BufEnter *.cc let b:fswitchdst  = 'h'
augroup END

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tagbar#enabled = 0 "与tagbar冲突，禁用airline的tagbar扩展


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 键盘映射
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leader键换成","
let mapleader = ","

nnoremap <Space>] <C-w>v<C-]><C-w>x<C-w>l
nnoremap <Space>q <C-w>q
nnoremap w+ :resize +10<CR>
nnoremap w- :resize -10<CR>
nnoremap w> :vertical resize +10<CR>
nnoremap w< :vertical resize -10<CR>


fu! OpenTerminal()
    " open split windows on the topleft
    topleft vsplit
    :call term_start('bash', {'curwin' : 1, 'term_finish' : 'close'})
endf
nnoremap <Space>t :call OpenTerminal()<cr>
