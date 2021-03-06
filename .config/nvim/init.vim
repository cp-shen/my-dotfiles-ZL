set packpath+=~/.vim,
source ~/.vimrc

if isdirectory($HOME . '/.vim/bundle')
    let g:plugdir = '~/.vim/bundle'
elseif isdirectory($HOME . '/.vim/plugged')
    let g:plugdir = '~/.vim/plugged'
endif

call plug#begin(plugdir)

"tools
"Plug 'vim-scripts/DoxygenToolKit.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/cpp_doxygen'
Plug 'scrooloose/nerdtree' "file tree
Plug 'tyru/caw.vim' "comment tool
"Plug 'gauteh/vim-cppman'

Plug 'terryma/vim-multiple-cursors'
    let g:multi_cursor_use_default_mapping = 0

    " Default mapping
    let g:multi_cursor_start_word_key      = '<C-n>'
    let g:multi_cursor_select_all_word_key = '<A-n>'
    let g:multi_cursor_start_key           = 'g<C-n>'
    let g:multi_cursor_select_all_key      = 'g<A-n>'
    let g:multi_cursor_next_key            = '<C-n>'
    let g:multi_cursor_prev_key            = '<C-p>'
    let g:multi_cursor_skip_key            = '<C-x>'
    let g:multi_cursor_quit_key            = '<Esc>'

Plug 'sbdchd/neoformat' "formatting tool
Plug 'francoiscabrol/ranger.vim'
    let g:ranger_map_keys = 0 "disable default key map
Plug 'rbgrouleff/bclose.vim' "required by ranger.vim
"Plug 'tpope/vim-eunuch' "sugar commands
Plug 'jiangmiao/auto-pairs'
    "Specify pairs for auto-pairs
    let g:AutoPairs =  {'(':')', '[':']', '{':'}'}
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace' "show and remove unwanted whitespaces
"Plug 'jlanzarotta/bufexplorer'

"tags
Plug 'ludovicchabant/vim-gutentags'

"languages
"Plug 'calviken/vim-gdscript3'
Plug 'mrk21/yaml-vim'
Plug 'rust-lang/rust.vim'

"languages syntax
Plug 'bfrg/vim-cpp-modern'
    let c_no_curly_error=1

    " Disable function highlighting (affects both C and C++ files)
    "let g:cpp_no_function_highlight = 1

    " Put all standard C and C++ keywords under Vim's highlight group `Statement`
    " (affects both C and C++ files)
    "let g:cpp_simple_highlight = 1

    " Enable highlighting of named requirements (C++20 library concepts)
    "let g:cpp_named_requirements_highlight = 1
Plug 'sheerun/vim-polyglot' "language pack to support highlight
    let g:polyglot_disabled = ['c/c++', 'yaml', 'rust']

" snippet engine
Plug 'SirVer/ultisnips'
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger=""
    let g:UltiSnipsJumpBackwardTrigger=""

    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical

" Snippets
Plug 'honza/vim-snippets'

"debugging tools
"Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

"apperance
Plug 'itchyny/lightline.vim'

"Plug 'luochen1990/rainbow'
    "let g:rainbow_active = 1

"colorschemes
Plug 'joshdick/onedark.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'cp-shen/Spacegray.vim'
    let g:spacegray_underline_search = 0
    let g:spacegray_use_italics = 1
    let g:spacegray_low_contrast = 0


"for vim-plug help message
Plug 'junegunn/vim-plug'

"fzf for file finding
Plug 'junegunn/fzf' ", { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"plugins for nvim only
if has('nvim')
    "autocompletion engine
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        "enable deoplete
        "let g:deoplete#enable_at_startup = 1

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "lsp support and completion
    "Plug 'autozimu/LanguageClient-neovim', {
        "\ 'branch': 'next',
        "\ 'do': 'bash install.sh',
        "\ }
        "Required for lsp operations modifying multiple buffers like rename.
        set hidden
        "register lsp servers
        let g:LanguageClient_serverCommands = {
            \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
            \ 'python': ['~/.local/bin/pyls'],
            \ 'lua': ['lua-lsp'],
            \ 'cpp': ['clangd'],
            \ 'c': ['clangd'],
            \ }
        let g:LanguageClient_autoStart = 1
endif

call plug#end()

"---------------------------------------------
"editor appearance settings
"---------------------------------------------

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  "< https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
"endif

set ruler
set number
set showcmd
set noshowmode
set nowrap
set showmatch "match braket
set hlsearch
set guifont=Fira\ Code:h12
set foldcolumn=0
set foldignore=
nnoremap z- zm
nnoremap z= zr
nnoremap zz za

syntax on

"highlight current line
"set cursorline
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"highlight current column
"set cursorcolumn
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

"add a switch key to show cursor line and column
"nnoremap <Leader>H :set cursorline! cursorcolumn!<CR>

"remove tool toolbar and left / right scroll bar
set guioptions-=T
set guioptions-=r
set guioptions-=L

"show TabLine when needed
set showtabline=1

"whitespace color
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_guicolor='red'

"onedark colorscheme setting
"Note! this should be placed before setting colorscheme
let g:onedark_termcolors = 16
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1

"one colorscheme setting
"Note! this should be placed before setting colorscheme
set background=dark
let g:one_allow_italics = 1

"set color scheme
colorscheme spacegray

"enable doxygen highlighting
let g:load_doxygen_syntax = 1
"--------------------------------------------
"keybindings
"--------------------------------------------

"set Leader key
map <Space> <Leader>

"bind key to toggle NERDTree
nnoremap <A-1> :NERDTreeFocus<CR>
nnoremap <A-2> :NERDTreeToggle<CR>

"set key to show full path
nnoremap <A-3> :echo expand('%:p')<CR>

"toggle lsp context menu
"nnoremap <Leader>L :call LanguageClient_contextMenu()<CR>

"reload file if changed by other program
nnoremap <Leader>ct :checktime<CR>

"reload config file
nnoremap <Leader>so :so $MYVIMRC<CR>

"bind keys for deoplete menu navigation
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <A-j> pumvisible() ? "\<C-n>" : "\<A-j>"
inoremap <expr> <A-k> pumvisible() ? "\<C-p>" : "\<A-k>"

"remap CR for deoplete to close popup menu
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
  "return pumvisible() ? deoplete#mappings#close_popup() : "\n"
"endfunction

"shortcut to paste from system clipboard
nmap <Leader><C-v> "+p

"shortcut to remove unwanted whitespaces
nnoremap <Leader>sw :StripWhitespace<CR>

"shortcut to use fzf
nnoremap <Leader>H :History<CR>
nnoremap <Leader>hi :History<CR>
nnoremap <Leader>F :Files<CR>
nnoremap <Leader>fi :Files<CR>
nnoremap <Leader>B :Buffers<CR>
nnoremap <Leader>ta :Tags<CR>
nnoremap <Leader>bt :BTags<CR>
nnoremap <A-t> :BTags<CR>
nnoremap <Leader>li :Lines<CR>
nnoremap <Leader>bl :BLines<CR>

"delete buffer
nnoremap <Leader>bd :bd<CR>

"window navigation
nmap <A-h> <C-w>h
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l

"tab navigation
nnoremap <Leader>tp :tabprevious<CR>
nnoremap <Leader>tn :tabnext<CR>

"tab operation
nnoremap <Leader>tt :tabnew term://zsh<CR>a
nnoremap <Leader>td :tabclose<CR>

"navigation of buffer

"nnoremap <C-k> :bprev<CR>

nnoremap <Leader><Space> :History<CR>

nnoremap <Leader>nh :noh<CR>

"save file
nnoremap <A-s> :w<CR>

"close
nnoremap <A-q> :bd<CR>

"terminal mode keybindings
tnoremap <C-\> <C-\><C-n>
tnoremap <A-\> <C-\><C-n>

"function! NvimGdbNoTKeymaps()
  "tnoremap <silent> <buffer> <esc> <c-\><c-n>
"endfunction

"let g:nvimgdb_config_override = {
  "\ 'key_next': '<C-n>',
  "\ 'key_step': '<C-s>',
  "\ 'key_finish': '<C-f>',
  "\ 'key_continue': '<C-c>',
  "\ 'key_until': '<C-u>',
  "\ 'key_breakpoint': '<C-b>',
  "\ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  "\ }

nmap <Leader>dg <Plug>cpp_doxygenInsert

nmap <Leader>R :RangerCurrentFile<CR>

"nnoremap gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <C-b> :call LanguageClient#textDocument_definition()<CR>

nnoremap <Leader><CR> i<CR><Esc>
"---------------------------------------------
"autocmd actions
"---------------------------------------------

function! MyVimEnterAction()
    if @% == ""
        " No filename for current buffer
        History
    "elseif filereadable(@%) == 0
        " File doesn't exist yet
        "startinsert
    "elseif line('$') == 1 && col('$') == 1
        " File is empty
        "startinsert
    endif
endfunction
autocmd VimEnter * call MyVimEnterAction()

"run neoformat on save
augroup fmt
  autocmd!
  "autocmd BufWritePre * undojoin | Neoformat
  "autocmd BufWritePre * Neoformat
augroup END

"---------------------------------------------
"environment variables
"---------------------------------------------
"let $FZF_DEFAULT_COMMAND = "find ~ -L"

"---------------------------------------------
"other misc settings
"---------------------------------------------

set title

"encoding
set encoding=utf-8

"new line = \n
set fileformat=unix

"set tab = 4 spaces
set tabstop=4 shiftwidth=4 expandtab

"match uppercase when search by lower
set ignorecase
set smartcase

"turn off bell
set belloff=all

"do not insert comment leader
autocmd FileType * setlocal formatoptions-=ro

"keyword dictionaries for completion
au FileType * execute 'setlocal dict+=~/.vim/dict/'.&filetype.'.vimdict'

"set underscore to be a word seperator
"set iskeyword-=_

"when navigating deoplete list, do not open scratch buffer
set completeopt-=preview

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumn
set signcolumn=auto

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

hi CocErrorSign guifg=#AF5F5F

nnoremap <expr><C-j> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-j>"
nnoremap <expr><C-k> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-k>"

nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <A-f> :Neoformat<CR>
nnoremap <leader>nf :Neoformat<CR>

let g:lightline = {
      \ 'colorscheme': 'spacegray',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'clock', 'fileformat', 'fileencoding', 'filetype', ] ]
      \ },
      \ 'component_function': {
      \   'clock': 'ShowCurTime'
      \ },
      \ }

function! ShowCurTime()
    return strftime('%H:%M')
endfunction

hi Todo ctermbg=52 ctermfg=12 guibg=NONE guifg=#A57A9E cterm=underline gui=None
hi SignColumn      ctermbg=233  ctermfg=250    guibg=#111314  guifg=#B3B8C4  cterm=NONE      gui=NONE
hi GitGutterAdd    guifg=#009900 guibg=<X> ctermfg=2 ctermbg=233
hi GitGutterChange guifg=#bbbb00 guibg=<X> ctermfg=3 ctermbg=233
hi GitGutterDelete guifg=#ff2222 guibg=<X> ctermfg=1 ctermbg=233
hi default CocUnderline cterm=underline gui=underline

autocmd BufNewFile,BufRead config set ft=conf
autocmd BufNewFile,BufRead *.fs set ft=glsl
autocmd BufNewFile,BufRead *.vs set ft=glsl

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <A-h> :noh<CR>
