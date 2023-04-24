set term=xterm
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
"set noautoindent
set winaltkeys=no" "关闭菜单快捷"
set guioptions=-m
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set ignorecase "不再区分大小写"

"C/C++ 注释"
set comments=://

"To hex modle
let s:hexModle = "N"
function! ToHexModle()
  if s:hexModle == "Y"
      %!xxd -r
      let s:hexModle = "N"
  else
      %!xxd
      let s:hexModle = "Y"
  endif
endfunction
map <F4> :call ToHexModle()<cr>

set pastetoggle=<F3>
"imap <F3> <Esc>:w<CR>i
"map <F3> <F3><Esc>

map <C-Z> :u<CR>
imap <C-Z> <Esc>:u<CR>i
imap <C-R> <Esc><C-R>i
map <F2> :Tlist<CR>
imap <F2> <Esc><F2>
map <F12> :make<CR>
imap <F12> <Esc><F12>
map <F8> :clist<CR>
imap <F8> <Esc><F8>

"增强检索功能"
"set tags=./tags,./../tags,./**/tags;
set tags=tags,./../tags,./../../tags;
set autochdir
set completeopt=longest,menu
"禁止自动改变当前Vim窗口的大小
let Tlist_Inc_Winwidth=0
"把方法列表放在屏幕的右侧
"let Tlist_Use_Right_Window=1
"让当前不被编辑的文件的方法列表自动折叠起来， 这样可以节约一些屏幕空间
let Tlist_File_Fold_Auto_Close=1 
"TlistToggle

set fileformats=unix,dos

if has("cscope")
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb

if has("cscope")
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb
" add any database in current directory
if filereadable("cscope.out")
cs add cscope.out
" else add database pointed to by environment
elseif $CSCOPE_DB != ""
cs add $CSCOPE_DB
endif
set csverb
set cscopetag
"set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
endif
endi

if has("autocmd")
au BufReadPost * if line("`\"") > 1 && line("`\"") <= line("$") | exe "normal! g`\"" | endif
" for simplicity, "  au BufReadPost * exe "normal! g`\"", is Okay.
endif

hi comment ctermfg=5

let Tlist_Show_One_File=1     "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow=1   "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Ctags_Cmd="/usr/bin/ctags" "将taglist与ctags关联

inoremap jj <Esc>

