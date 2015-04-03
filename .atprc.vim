" Base configuration for Vim Automatic TeX Plugin
"
" Disable ATP's automatic compiling.
let b:atp_autex = 0

"let g:atp_Compiler='python'
let g:atp_Compiler='bash'

let b:atp_TexCompiler = 'pdflatex'
let b:atp_TexOptions = '-synctex=1 -shell-escape'

" Treat all tex files as LaTeX.
let b:atp_TexFlavor = 'tex'

let g:atp_StatusLine = ""
let b:atp_Viewer = 'zathura'
