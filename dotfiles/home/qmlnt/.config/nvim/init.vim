set langmap=hi,HI,jJ,JK,ko,KO,le,LE,nj,Nn,ek,EN,ih,IH,ol,OL
"set langmap=hi,HI,jJ,JK,ko,KO,le,LE,nj,Nn,ek,EN,ih,IL,ol,OH
"set langmap=hi,HI,jJ,JK,kn,KN,le,LE,nj,NL,ek,EH,ih,IO,ol,Oo
"set langmap=hi,HI,je,JE,ko,KO,ln,LN,nj,NL,ek,EH,ih,IJ,ol,OK

set noswapfile              "Don't need swap
set number                  "Enumerate lines
set autoindent              "By previous line
set smarttab
set expandtab               "Tabs to spaces
set tabstop=4               "Spaces per tab
set shiftwidth=4            "For autoindent
set softtabstop=4
set mouse=a                 "Mouse mode all
set cursorline      "Don't like it
set clipboard=unnamedplus

set nowrap

colorscheme industry

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
