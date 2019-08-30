" Turn off compatibility mode (prevents errors related to line-continuation in
" plugins)
set nocompatible


" Syntax highlighting
syntax on
set termguicolors
colorscheme base16-eighties

" Line numbers
set number

" Show commands while being typed
set showcmd

" Hightlight search terms
set hlsearch

" Tabs and indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Set indentation to 2 spaces when file is .yml .tf or .sh
au FileType yaml setlocal sw=2 ts=2 sts=2
au BufRead,BufNewFile *.tf setlocal sw=2 ts=2 sts=2
au FileType sh setlocal sw=2 ts=2 sts=2
au FileType markdown setlocal sw=2 ts=2 sts=2

" Make backspace key work
set backspace=indent,eol,start

" Trailing whitespace removal command
:command CleanTrail %s/\s\+$//e

" Show matching parens characters
set showmatch

" Enable filetype support
filetype on
filetype plugin on
filetype plugin indent on

" Make markdown easier to work with
autocmd FileType markdown :set tw=72

" Vim-go configuration
 let g:go_fmt_command = "goimports"
 let g:go_addtags_transform="camelcase"
" " let g:go_metalinter_autosave = 1
 let g:go_highlight_functions = 1
" " let g:go_highlight_function_arguments = 1
 let g:go_highlight_function_calls = 1
 let g:go_highlight_types = 1
" " let g:go_highlight_fields = 1
 let g:go_highlight_operators = 1
 let g:go_highlight_build_contraints = 1
 let g:go_highlight_extra_types = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


" Run terraform fmt when saving Terraform files
au BufWritePost,FileWritePost *.tf !terraform fmt <afile>
