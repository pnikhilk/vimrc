set nocompatible

if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/bundle')

" Plugins
    " Language
        " web
            Plug 'elzr/vim-json'
            Plug 'othree/html5.vim'
            Plug 'pangloss/vim-javascript'
            Plug 'rstacruz/sparkup'
        " python
            Plug 'python-mode/python-mode'
        " markdown
            Plug 'jtratner/vim-flavored-markdown'
            Plug 'tpope/vim-markdown'

    " Graphics
        Plug 'nanotech/jellybeans.vim'
		Plug 'altercation/vim-colors-solarized'
        Plug 'itchyny/lightline.vim'
        Plug 'kien/rainbow_parentheses.vim'

    " Utils
        Plug 'scrooloose/nerdtree'
        Plug 'kien/ctrlp.vim'
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-git'
        Plug 'tpope/vim-commentary'
        Plug 'scrooloose/syntastic'
        Plug 'Valloric/YouCompleteMe'

    " Misc
        Plug 'aperezdc/vim-template'
        Plug 'godlygeek/tabular'
        Plug 'raimondi/delimitMate'                     " Auto-completion for quotes, parens, etc

    " To Learn
        " Plug 'svermeulen/vim-easyclip'                " Simplified clipboard functionality
call plug#end()

""""""""""""""""
" Misc Fn defs "
""""""""""""""""
    func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
    endfunc

    func! RefreshPlugs()
        exe 'PlugClean'
        exe 'PlugInstall'
    endfunc

	func! InstallPlugs()
		exe 'PlugInstall'
	endfunc

    func! SetTabWidth(width)
        exe 'set tabstop='    .a:width
        exe 'set shiftwidth=' .a:width
        exe 'set softtabstop='.a:width
    endfunc

"""""""
" Set "
"""""""

" Terminal
"    set term=screen-256color
    set t_Co=256
    set ttyfast

" Encoding
    set termencoding=utf-8                              " Too young to use ASCII
    set encoding=utf-8                                  " No seriously, way too young to use ASCII

" Wild Menu
    set wildmode=list:longest,full
    set wildignore=*.out,*.o,*~,*.pyc,**.git,**.env,**BUILD
    set wildmenu

" Indentation
    filetype plugin indent on
    syntax on
    set autoindent
    set smartindent
    set cc=+1                                           " Mark no man's land

" Text settings
    call SetTabWidth(4)
    set textwidth=80                                    " Max text width
    set showcmd                                         " Display incomplete commands

" Search
    set nohlsearch                                      " Highlight searches
    set incsearch                                       " Do incremental searching
    set ignorecase                                      " Case-insensitive search
    set smartcase                                       " Smartly searches

" Notifications
    set report=0                                        " Tell me how many lines commands change
    set number                                          " Show line numbers
"    set relativenumber                                  " Show relative line numbers
    set ruler                                           " Show the cursor position all the time
    set ls=2                                            " Always show status line

" Folds
    set foldenable                                      " Folding FTW.
    set foldmethod=indent                               " My files are always neatly indented
    set foldlevel=100                                   " Don't autofold

" Backup files - Nah!
    set nobackup                                        " Do not keep backup files
    set noswapfile                                      " Do not write annoying swap files
    set nowritebackup

" Misc Behaviour
    set backspace=eol,start,indent
    set lazyredraw                                      " Don't redraw while executing macros
    set showmatch
    set magic
    set autoread                                        " Auto read when file is changed from outside
    set title

" (Hopefully) removes the delay when hitting esc in insert mode
    set ttimeout
    set ttimeoutlen=1

" Key Mapping

    " Fn Keys
        map <F4> :source $MYVIMRC<CR>
        map <F6> :call RefreshPlugs()<CR>

    " Git (requires vim-fugitive)
        map <leader>gs :Gstatus<CR>
        map <leader>gd :Gvdiff<CR>
        map <leader>gc :Gcommit<CR>
        map <leader>gl :Glog<CR>
        map <leader>gp :Git push<CR>

    " Custom Leaders
        map <leader>q :q!<CR>
        map <leader>w :w!<CR>
        map <leader>x :x<CR>
        map <leader>i gg=G''
        map <leader>v :tabe $MYVIMRC<CR>
        map <leader>pp :setlocal paste!<CR>

    " Navigation
        map <C-n> :NERDTreeToggle<CR>
        map <C-S-a> ^
        map <C-S-e> $
        map <C-H> <C-W><C-H>
        map <C-J> <C-W><C-J>
        map <C-K> <C-W><C-K>
        map <C-L> <C-W><C-L>

" ColorSchemes
    set background=dark
"	colorscheme solarized
    colorscheme jellybeans
    set cursorline
    hi CursorLine term=bold cterm=bold

" CtrlP settings
    let g:ctrlp_custom_ignore = ''
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_max_depth = 10

" Python Mode
"    let g:pymode_python = "python3"
    let g:pymode_lint_on_fly = 1

    let g:pymode_lint_ignore = "E501"
    let g:pymode_quickfix_maxheight = 3
    let g:pymode_quickfix_minheight = 1
    let g:pymode_rope =0 
    let g:pymode_rope_completion = 1
    let g:pymode_rope_complete_on_dot = 0
    let g:pymode_rope_lookup_project = 1


" Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

" Autocmds
    " Filetypes
        autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
        autocmd BufNewFile,BufRead .jshintrc,.bowerrc setlocal filetype=json

    " Git
        autocmd Filetype gitcommit setlocal spell textwidth=72

    " Indentation
        autocmd Filetype c,java,cpp,js,json :call SetTabWidth(2)
        autocmd Syntax * RainbowParenthesesLoadSquare
        autocmd Syntax * RainbowParenthesesLoadBraces

    " Misc
        autocmd BufWrite !*.md :call DeleteTrailingWS()
        autocmd CompleteDone * pclose  " Close autocomplete window after completion

" User interface configuration "
""""""""""""""""""""""""""""""""
    set mouse=a            " I (sometimes) like using my mouse
    set noerrorbells       " Hate console beeps.
    let g:ycm_server_python_interpreter = '/usr/bin/python'
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

