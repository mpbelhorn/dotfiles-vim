" General Settings
"==============================================================================

set nocompatible
set encoding=utf8

" Load bundled plugins now, but configure them later.
silent! call pathogen#infect()

syntax on
filetype on
filetype plugin indent on
set foldmethod=marker
"set foldmethod=syntax
"set foldmethod=manual
"set foldmethod=expr
"set foldmethod=indent
set foldlevel=3
set timeoutlen=1000 ttimeoutlen=0
if version >= 700
   set spl=en spell
   "set nospell
endif
set modelines=5
set shortmess+=I
set grepprg=grep\ -nH\ $*

set wildmenu
set wildmode=list:longest,list:full

set mouse=a
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

set incsearch
set hlsearch
set hidden

set autoindent " -------- Automatically insert shifts by filetype
set expandtab " ========= Use spaces instead of <Tab>
set smarttab " ---------- Insert 'shiftwidth' blanks on <Tab> at start of line.
set tabstop=2 " ========= N spaces = 1 <Tab>
set softtabstop=2 " ----- N spaces per <Tab> when mixed with spaces
set shiftwidth=2 " ====== N spaces text is shifted per indent
set textwidth=80 " ------ Number of columns before text is wrapped.

set showcmd
"" 'title' is `off` by default UNLESS it can be restored. Setting 'title' on
"" will force 'titleold' string to display when original title cannot be
"" restored. Let's leave this unset (automatic mode) forever:
"set title
"set titleold=""
set scrolloff=3
set number
set wrap

set showmatch " Breifly jump to matched bracket on bracket insert.
set matchtime=2 " Deciseconds to highlight matched paren.

set laststatus=2 "Last window open always has a statusline
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

set fileformats=unix,dos,mac
set autochdir ""WARNING - May break plugins

set backup " Make backup before overwriting file, persist after write.
set writebackup " Backup before writing file
set backupdir=~/.vim/tmp/backup//
set backupskip=/tmp/*,/private/tmp/*"

set noswapfile
set directory=~/.vim/tmp/swap//

set history=1000
set undofile
set undolevels=100
set undodir=~/.vim/tmp/undo//

let g:clipbrdDefaultReg = '+'
if has('unnamedplus')
  " For all operations that would normally use the un-named register `""` (ie,
  " yank delete put ...):
  " Use the `"+` clipboard register for all these operations and also
  " use the `"*` clipboard register for yank alone.
  set clipboard=unnamed,unnamedplus 
endif

" Now and forever, *.md files are markdown: not modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Colors and fonts
" =============================================================================

set t_Co=256
if has("gui_running")
  set guioptions-=T       "Remove toolbar.
  set guioptions-=m       "Remove menu bar
  set guioptions-=r       "Remove right-hand scroll bar
  set guioptions-=L       "Remove left-hand scroll bar
  set guioptions+=e       "Add tab pages.
  set guitablabel=%M\ %t  "Label tab as 'Mode Title'
else
  set background=dark
endif
silent! colorscheme solarized

" Custom Functions
"==============================================================================

"Open URL in browser
function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!firefox ".line
endfunction

"Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "#solarized#jellybeans#wombat256mod#railscasts#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
nnoremap <silent><F8> :execute RotateColorTheme()<CR>

"Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste
func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
nnoremap <silent><F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

"Todo List Mode
function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction
nnoremap <silent><Leader>todo :execute TodoListMode()<CR>

" Toggle long line highlighting.
function! s:LongLineHLToggle()
  if !exists('w:longlinehl')
    let w:longlinehl = matchadd('ErrorMsg', '.\%>80v', 0)
    echo "Long lines highlighted"
  else
    call matchdelete(w:longlinehl)
    unlet w:longlinehl
    echo "Long lines unhighlighted"
  endif
endfunction
nnoremap <Leader>H :call<SID>LongLineHLToggle()<cr>
highlight OverLength ctermbg=none cterm=none
match OverLength /\%>80v/

"Mappings
"==============================================================================
"Remap the movement keys into the more sane inverted T arrangement, jkil
noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap h i

" consistent menu navigation
inoremap <C-k> <C-n>
inoremap <C-i> <C-p>

let mapleader = ","
let maplocalleader = "\\"

" Invert ` and ' roles for marked line jumps.
nnoremap ' `
nnoremap ` '

" Leader window switching.
nnoremap <silent><leader>i :wincmd k<CR>
nnoremap <silent><leader>k :wincmd j<CR>
nnoremap <silent><leader>j :wincmd h<CR>
nnoremap <silent><leader>l :wincmd l<CR>

" New Window Splits
" The 'sx' mappings split the current window, placing the new window in the
" direction indicated by x∈[h,j,k,l] w.r.t. the active window. The 'ssx'
" mappings span the full height or width of vim.
nnoremap <leader>sj :leftabove vnew<CR>
nnoremap <leader>sfj :topleft vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sfl :botright vnew<CR>
nnoremap <leader>si :leftabove new<CR>
nnoremap <leader>sfi :topleft new<CR>
nnoremap <leader>sk :rightbelow new<CR>
nnoremap <leader>sfk :botright new<CR>

" Quick save
nnoremap <leader>w :w<CR>

" Close buffer
nnoremap <leader>d :bd<CR>

" Close window
nnoremap <leader>q :q<CR>

" Show open buffers
nnoremap <leader>b :buffers<CR>

" Toggle spelling
nnoremap <leader>ss :setlocal spell!<CR>

" Clear highlighting
nnoremap <silent><leader>h :noh<CR>

" Toggle highlighting the cursor location
nnoremap <leader>ch :setlocal cursorline!<CR>:setlocal cursorcolumn!<CR>

" ^c to Copy
nnoremap <C-c> "+y<CR>

" Copy/Paste to X CLIPBOARD
if has("clipboard")
  nnoremap <silent><leader>xc "+y<CR>
else
  nnoremap <silent><leader>xc :w !xsel -i -b<CR>
  " map <leader>cp :w !xsel -i -p<CR>
  " map <leader>cs :w !xsel -i -s<CR>
  nnoremap <silent><leader>xp :r!xsel -p<CR>
  " map <leader>ps :r!xsel -s<CR>
  " map <leader>xv :r!xsel -b<CR>
end

" Cope commands - Lists errors in a new window.
nnoremap <leader>sc :botright cope<CR>
"map <leader>co ggVGy:tabnew<CR>:set syntax=qf<CR>pgg
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

" Toggle relative line numbers.
nnoremap <silent><leader>n :set rnu! rnu? <cr>

" Open (g)vimrc
nnoremap <silent><Leader>ev :e ~/.vimrc<CR>
nnoremap <silent><Leader>eg :e ~/.gvimrc<CR>


" These center window on search matches.
nnoremap N Nzzzv
nnoremap n nzzzv


"Plugins
"==============================================================================

"Vim Session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

"#Airline
" Use special fonts (~/.fonts) for airline special symbols.
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamecollapse = 1 " /a/m/model.rb

