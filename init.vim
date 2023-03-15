call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'puremourning/vimspector'

call plug#end()

lua << EOF
require("telescope").load_extension "file_browser"
require'nvim-web-devicons'.setup {
 color_icons = true;
 default = true;
 strict = true;
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
require'nvim-web-devicons'.get_icons()
EOF

colorscheme base16-default-dark
if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME
endif

fu! SaveSession(path = './.vim/session.vim')
    call inputsave()
    let name = input('Save session as... ', a:path)
    call inputrestore()
    call system('mkdir -p $(dirname ' . a:path . ')') 
    execute 'mksession! ' . name 
    redraw
    echo 'Session saved to ' . name . ' !'
endf

set number
set ignorecase
set incsearch
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set wildmode=longest,list
filetype plugin indent on
set clipboard=unnamedplus
set ttyfast
set noswapfile
set encoding=utf8
set clipboard=unnamedplus
command! -nargs=* -complete=file SaveSession call SaveSession(<f-args>) 

nnoremap `sh :terminal<CR>Acd %:p:h<CR>
nnoremap `ss :SaveSession<CR>
nnoremap `tc :tabclose<CR> 
nnoremap `tn :tabnew<CR>
nnoremap `w <C-w>
nnoremap <leader>fb <cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>
nnoremap <leader>fg <cmd>Telescope live_grep search_dirs=.<CR>
nmap <Leader>di <Plug>VimspectorBalloonEval
xmap <Leader>di <Plug>VimspectorBalloonEval

