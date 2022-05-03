""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
set encoding=utf-8
set number relativenumber
syntax enable
syntax on
set nocompatible
set noswapfile
set scrolloff=7
set backspace=indent,eol,start
"set colorcolumn=81 "can write over column, not past it
set fileformat=unix
set mouse=a
set splitbelow
set splitright
set ignorecase
set fileignorecase
set termguicolors
set hidden

set list
set listchars=tab:·\ 

set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon100

let g:gruvbox_contrast_dark='soft'
colorscheme purpura

" Always show tabs
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode

filetype plugin on
filetype plugin indent on

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set cindent

let g:mapleader = "\<Space>"
"nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
"nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

nnoremap <C-H> <C-W><C-W>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"map <ScrollWheelUp> <C-U>
"map <ScrollWheelDown> <C-D>

"nmap <leader>gs :G<CR>
"nmap <leader>gh :diffget //3<CR>
"nmap <leader>gu :diffget //2<CR>

"nnoremap <C-p> :GFiles <CR>

nnoremap <leader><space> :History <CR>
"nnoremap <leader>lf :Lf <CR>
"nnoremap <leader>lc :Lfcd <CR>

nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <silent> <leader>z :ZenMode<CR>

"nnoremap <silent> <CR> :noh<CR>
noremap <silent> <esc> :<C-U>noh<esc>

nnoremap <leader>/ :BLines<CR>

:nmap <leader>e :CocCommand explorer<CR>

nnoremap <silent> <Tab>n :enew<CR>
nnoremap <silent> <Tab>k :bnext<CR>
nnoremap <silent> <Tab>j :bprevious<CR>
nnoremap <silent> <Tab>h :bfirst<CR>
nnoremap <silent> <Tab>l :blast<CR>
nnoremap <silent> <Tab>q :bd<CR>
nnoremap <silent> <Tab>Q :bd!<CR>

nnoremap <silent> <Tab>1 :buffer 1<CR>
nnoremap <silent> <Tab>2 :buffer 2<CR>
nnoremap <silent> <Tab>3 :buffer 3<CR>
nnoremap <silent> <Tab>4 :buffer 4<CR>
nnoremap <silent> <Tab>5 :buffer 5<CR>
nnoremap <silent> <Tab>6 :buffer 6<CR>
nnoremap <silent> <Tab>7 :buffer 7<CR>
nnoremap <silent> <Tab>8 :buffer 8<CR>
nnoremap <silent> <Tab>9 :buffer 9<CR>
nnoremap <silent> <Tab>0 :buffer 10<CR>

"nnoremap <silent>    <Tab>j :BufferPrevious<CR>
"nnoremap <silent>    <Tab>k :BufferNext<CR>
"
"nnoremap <silent>    <Tab>J :BufferMovePrevious<CR>
"nnoremap <silent>    <Tab>K :BufferMoveNext<CR>
"
"nnoremap <silent>    <Tab>h :BufferGoto 1<CR>
"nnoremap <silent>    <Tab>l :BufferLast<CR>
"
"nnoremap <silent>    <Tab>1 :BufferGoto 1<CR>
"nnoremap <silent>    <Tab>2 :BufferGoto 2<CR>
"nnoremap <silent>    <Tab>3 :BufferGoto 3<CR>
"nnoremap <silent>    <Tab>4 :BufferGoto 4<CR>
"nnoremap <silent>    <Tab>5 :BufferGoto 5<CR>
"nnoremap <silent>    <Tab>6 :BufferGoto 6<CR>
"nnoremap <silent>    <Tab>7 :BufferGoto 7<CR>
"nnoremap <silent>    <Tab>8 :BufferGoto 8<CR>
"nnoremap <silent>    <Tab>9 :BufferGoto 9<CR>
"
"nnoremap <silent>    <Tab>q :BufferClose<CR>
"
"let bufferline.icon_close_tab = ''
"let bufferline.icon_close_tab_modified = '●'
"let bufferline.animation = v:true
"let bufferline.auto_hide = v:true

nnoremap K i<CR><Esc>k$

tnoremap <ESC> <C-\><C-n>

nnoremap Y yg_

vnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

let s:twoSpaceMode = 0
function! ToggleTabMode()
	if s:twoSpaceMode
		set ts=4 sw=4 noexpandtab
		let s:twoSpaceMode = 0
	else
		set ts=2 sw=2 expandtab
		let s:twoSpaceMode = 1
	endif
endfunction


map <leader>ct :call ToggleTabMode()<CR>

let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
	let s:wrapenabled = 1
  endif
endfunction
map <leader>cw :call ToggleWrap()<CR>

function! WebOpen()
	!brave expand('%:p')
endfunction

"let g:UltiSnipsSnippetDir='./ultisnips'
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

autocmd FileType fish compiler fish

autocmd FileType nix set ts=4 sw=4 noexpandtab

autocmd FileType haskell set ts=2 sw=2 expandtab

autocmd FileType markdown set breakindent

"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"autocmd FileType java JCEnable
"autocmd FileType java set makeprg=javac\ %
"set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C.%#

"map <leader>ao :lopen<CR>
"map <leader>ac :lclose<CR>


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>c[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>c] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cc <Plug>(coc-rename)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nnoremap <silent><nowait> <leader>cl  :<C-u>CocList -I symbols<cr>

nnoremap <silent> <leader>cs :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"autocmd CursorHold * silent call CocActionAsync('highlight')

"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_sign_error = '✘'
"let g:ale_sign_warning = '⚠'
"
"let g:ale_open_list = 0
"let g:ale_loclist = 0
"
"let g:ale_linters = {
"	\  'python': ['pylint', 'pylsp'],
"	\  'java': ['javac', 'java-language-server'],
"	\  'nix': ['rnix-lsp'],
"	\  'javascript': ['tsserver'],
"	\  'cpp': ['clangd'],
"	\ }
"
"let g:ale_fixers = {
"	\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"	\   'javascript': ['eslint'],
"	\}

"let g:ale_completion_enabled = 1
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('sources', {
"	\ '_': ['ale']
"	\})

"let g:ale_fix_on_save = 1
"let g:lf_map_keys=0
"let g:lf_open_new_tab=0
"let g:lf_replace_netrw = 1

let g:rainbow_active = 1

let g:ctrlp_show_hidden = 1

let g:ctrlp_max_files = 0

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](target|node_modules|\.git)$',
  \ 'file': '\v\.(exe|so|dll|o)$',
  \ 'link': '',
  \ }

let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}

let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

nmap     <leader>ff <Plug>CtrlSFPrompt
vmap     <leader>ff <Plug>CtrlSFVwordPath
vmap     <leader>fF <Plug>CtrlSFVwordExec
nmap     <leader>fw <Plug>CtrlSFCwordPath
nmap     <leader>fW <Plug>CtrlSFPwordPath
nnoremap <leader>fo :CtrlSFOpen<CR>

nnoremap <Leader>tf :lua require'telescope.builtin'.find_files{}<CR>
vnoremap <Leader>tv :lua require'telescope.builtin'.grep_string{}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemode = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme = 'minimalist'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'VL',
    \ ''     : 'VB',
    \ }

let g:airline_focuslost_inactive = 1
let g:airline_stl_path_style = 'short'

let g:airline_section_z = ''

let g:user_emmet_mode='a'
let g:user_emmet_install_global = 1
"autocmd FileType html,css,ejs,js EmmetInstall
"let g:user_emmet_leader_key='<leader>'

let g:suda_smart_edit = 1

let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'

set signcolumn=yes
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

nmap <leader>* viwo<esc>i*<esc>ea*<esc>b
nmap <leader>wg f]la/glossary/<esc>F[
let g:vimwiki_list = [{'path':'/home/alexs/vimwiki', 'syntax':'markdown', 'ext':'.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:taskwiki_markup_syntax = 'markdown'
let g:markdown_folding = 1


" subscript lowercase
execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs js " . 0x2C7C
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093

" superscript lowercase
execute "digraphs aS " . 0x1d43
execute "digraphs bS " . 0x1d47
execute "digraphs cS " . 0x1d9c
execute "digraphs dS " . 0x1d48
execute "digraphs eS " . 0x1d49
execute "digraphs fS " . 0x1da0
execute "digraphs gS " . 0x1d4d
execute "digraphs hS " . 0x02b0
execute "digraphs iS " . 0x2071
execute "digraphs jS " . 0x02b2
execute "digraphs kS " . 0x1d4f
execute "digraphs lS " . 0x02e1
execute "digraphs mS " . 0x1d50
execute "digraphs nS " . 0x207f
execute "digraphs oS " . 0x1d52
execute "digraphs pS " . 0x1d56
execute "digraphs rS " . 0x02b3
execute "digraphs sS " . 0x02e2
execute "digraphs tS " . 0x1d57
execute "digraphs uS " . 0x1d58
execute "digraphs vS " . 0x1d5b
execute "digraphs wS " . 0x02b7
execute "digraphs xS " . 0x02e3
execute "digraphs yS " . 0x02b8
execute "digraphs zS " . 0x1dbb

" superscript uppercase
execute "digraphs AS " . 0x1D2C
execute "digraphs BS " . 0x1D2E
execute "digraphs DS " . 0x1D30
execute "digraphs ES " . 0x1D31
execute "digraphs GS " . 0x1D33
execute "digraphs HS " . 0x1D34
execute "digraphs IS " . 0x1D35
execute "digraphs JS " . 0x1D36
execute "digraphs KS " . 0x1D37
execute "digraphs LS " . 0x1D38
execute "digraphs MS " . 0x1D39
execute "digraphs NS " . 0x1D3A
execute "digraphs OS " . 0x1D3C
execute "digraphs PS " . 0x1D3E
execute "digraphs RS " . 0x1D3F
execute "digraphs TS " . 0x1D40
execute "digraphs US " . 0x1D41
execute "digraphs VS " . 0x2C7D
execute "digraphs WS " . 0x1D42

" sets (double-struck)
execute "digraphs A\\|"  . 0x1D538
execute "digraphs C\\|"  . 0x2102
execute "digraphs I\\|"  . 0x1D540
execute "digraphs N\\|"  . 0x2115
execute "digraphs P\\|"  . 0x2119
execute "digraphs Q\\|"  . 0x211A
execute "digraphs R\\|"  . 0x211D
execute "digraphs Z\\|"  . 0x2124

" tacks (up-tack is already in standard digraphs)
execute "digraphs T-" . 0x22A4
execute "digraphs \\|-"  . 0x22a2
execute "digraphs -\\|"  . 0x22a3
execute "digraphs \\|="  . 0x22a8

" Set notation
execute "digraphs !("  . 0x2209

" Star
execute "digraphs **"  . 0x22C6

"Not approximately equal to
execute "digraphs ?!"  . 0x2249

hi SpellBad cterm=underline "ctermfg=203 guifg=#ff5f5f"
