" Turn off compatibility mode (prevents errors related to line-continuation in
" plugins)
set nocompatible

" Syntax highlighting
syntax on

" Line numbers
set number

" Show commands while being typed
set showcmd

" Hightlight search terms
set hlsearch

" Use the computer's default clipboard (windows should use unnamed)
set clipboard=unnamedplus

autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) . ' | xclip -selection clipboard')

" Tabs and indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Set indentation to 2 spaces when file is .yml or .tf
au FileType yaml setlocal sw=2 ts=2 sts=2 
au BufRead,BufNewFile *.tf setlocal sw=2 ts=2 sts=2


" Make backspace key work
set backspace=indent,eol,start

" Show matching parens characters
set showmatch

" Enable filetype support
filetype on
filetype plugin on
filetype plugin indent on

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

" Run terraform fmt when saving Terraform files
au BufWritePost *.tf !terraform fmt -write=true %
