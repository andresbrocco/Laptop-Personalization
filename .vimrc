" vim:foldmethod=marker:foldlevel=0

" Basic {{{
	" Ward off unexpected things that your distribution might
	" have made, as well as sanely reset options when re-sourcing .vimrc
	set nocompatible
	
	" Modelines have historically been a source of security vulnerabilities. As
	" such, it may be a good idea to disable them and use the securemodelines
	" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
	set modeline
	set modelines=1
	
	" Stop certain movements from always going to the first character of a line.
	" While this behaviour deviates from that of Vi, it does what most users
	" coming from other editors would expect.
	set nostartofline
	
	" Instead of failing a command because of unsaved changes, instead raise a
	" dialogue asking if you wish to save changed files.
	set confirm
	
	" Use visual bell instead of beeping when doing something wrong
	set visualbell
	
	" And reset the terminal code for the visual bell. If visualbell is set, and
	" this line is also included, vim will neither flash nor beep. If visualbell
	" is unset, this does nothing.
	set t_vb=
	
	" Quickly time out on keycodes, but never time out on mappings
	set notimeout ttimeout ttimeoutlen=100

	" Allow saving files as sudo when I forgot to start vim using sudo
	" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
	if has("unix")
		cmap w!! w !sudo tee > /dev/null %
	endif
" }}}
" Display {{{
	" Show partial commands in the bottom right of the screen. 
	set showcmd
	
	" Set the command window height to 2 lines, to avoid many cases of having to
	" 'press <Enter> to continue'
	set cmdheight=2
	
	" Display hybrid line numbers on the left
	set number relativenumber
	augroup numbertoggle
	  autocmd!
	  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | endif
	  autocmd BufLeave,FocusLost,InsertEnter,WinEnter   * if &nu | set nornu | endif
	augroup END
	
	" Show file name at the top
	set title
	
	" Enable 'set listchars'
	set list
	
	" Try to always keep the cursor at the middle of the file
	set scrolloff=999
	
	" Display horizontal line over cursor
	set cursorline 
	
	" Indicate width limit at specified number of columns.
	set colorcolumn=80
	set textwidth=80
	
	" Fold automatically based on indentation, for files with more than 10 
	" possible folds, limiting nested folding to 10.
	set foldenable
	set foldlevelstart=10 
	set foldnestmax=10
	set foldmethod=indent
	
	" Set proper comment highlighting in json files.
	autocmd FileType json syntax match Comment +\/\/.\+$+
	
	" Don't wrap lines
	set nowrap
	
	" Set cursorline only in active window and NERDTree
	augroup CursorlineOnlyInActiveWindow
		autocmd!
		autocmd VimEnter,WinEnter,BufEnter * setlocal cursorline
		autocmd WinLeave * if &filetype != "nerdtree" | setlocal nocursorline | endif
	augroup END
	"" }}}
" Autocompletion and Spelling {{{
	" Attempt to determine the type of a file based on its name and possibly its
	" contents. Use this to allow intelligent auto-indenting for each filetype,
	" and for plugins that are filetype specific.
	filetype indent plugin on
	
	" Enable syntax highlighting
	syntax on
	
	" Visual autocomplete for command menu
	set wildmenu
	
	" Correction based on english dictionary
	"set spell 
" }}}
" Multiple Windows and Tabs {{{
	" Vim with default settings does not allow easy switching between multiple 
	" files in the same editor window. Users can use multiple split windows or 
	" multiple tab pages to edit multiple files, but it is still best to 
	" enable an option to allow easier switching between files.
	
	" One such option is the 'hidden' option, which allows you to re-use the 
	" same window and switch from an unsaved buffer without saving it first. 
	" Also allows you to keep an undo history for multiple files when re-using 
	" the same window in this way. Note that using persistent undo also lets 
	" you undo in multiple files even in the same window, but is less 
	" efficient and is actually designed for keeping undo history after 
	" closing Vim entirely. Vim will complain if you try to quit without saving
	" and swap files will keep you safe if your computer crashes.
	set hidden
	
	" Note that not everyone likes working this way (with the hidden option).
	" Alternatives include using tabs or split windows instead of re-using the 
	" same window as mentioned above, and/or either of the following options:
	" set confirm
	" set autowriteall
	
	" Do not equalize sizes after window is closed or splitted
	" set noequalalways 
	
	" Open splits on the right and below
	set splitbelow
	set splitright

	" " Map the leader to change window focus
	" noremap <silent> <leader>h <C-W><C-H>
	" noremap <silent> <leader>j <C-W><C-J>
	" noremap <silent> <leader>k <C-W><C-K>
	" noremap <silent> <leader>l <C-W><C-L>

	" Map the leader arrows to resize the current window
	noremap <silent> <C-W>< :exe "vertical resize " . (winwidth(0) * 95/100)<CR>
	noremap <silent> <C-W>- :exe "resize " . (winheight(0) * 80/100)<CR>
	noremap <silent> <C-W>+ :exe "resize " . (winheight(0) * 120/100)<CR>
	noremap <silent> <C-W>> :exe "vertical resize " . (winwidth(0) * 110/100)<CR>

	" Automatically resize splits when resizing window
	autocmd VimResized * wincmd = 
	" }}}
" Terminal mode {{{
	" Open a terminal automatically when no file is given as input. This line
	" has to be before NERDTreeFocus
	" autocmd VimEnter * term ++kill=term
	"
	" Mappings: (neither <Esc> nor <F1> can be used... so I'll keep with the
	" default)
	" tnoremap <F1> <C-W>N
" }}}
" Search {{{
	" Highlight searches (use <C-L> to temporarily turn off highlighting)
	set hlsearch
	noremap <C-L> :nohl<CR><C-L>
	
	" Use case insensitive search, except when using capital letters
	set ignorecase
	set smartcase

	" Show total matches and current index in the command line bottom right.
	set shortmess-=S
	" }}}
" Indentation {{{
	" When opening a new line and no filetype-specific indenting is enabled, keep
	" the same indent as the line you're currently on. Useful for READMEs, etc.
	set autoindent
	
	" How many columns a tab counts for. Affect how existing text will be
	" displayed.
	set tabstop=2

	" expandtab: When hitting TAB in insert mode, automatically produces the 
	" appropriate number of spaces set in tabstop.
	set noexpandtab

	" How many columns text is indented with the reindent operations (<< and >>).
	set shiftwidth=2

	" When expandtab is set, vim will ignore this, and use tabstop value. When is
	" not set, if softtabstop is less than tabstop, vim will use a combination of
	" tabs and spaces to make up the desired spacing. When softtabstop equals
	" tabstop, vim will use only tabs.
	" set softtabstop=2

	" Set the representation of whatever key I want
	set listchars=tab:\|\ 
	
" }}}
" Mappings {{{
	" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
	" which is the default
	map Y y$
	map L $
	map H ^

	" Disable <Backspace>, <C-Backspace> and <Return> in normal mode (by default
	" they weirdely move the cursor)
	nnoremap  <NOP>
	nnoremap  <NOP>
	nnoremap  <NOP>
	nnoremap <Space><Space> <NOP>
	
	" Map <C-n> to open NERDTree
	noremap <C-N> :NERDTreeToggle<Enter>
	
	" Map <C-J> to insert empty line below current, analogous to <S-J> 
	nnoremap <C-J> m`o<Esc>0"_D`` 
	
	" Allow backspacing over autoindent, line breaks and start of insert action
	set backspace=indent,eol,start

	" The following mappings are not working when NERDTree is opened:
		" " Try to always keep the cursor at the middle of the file
		" nnoremap <C-B> 22kzz
		" nnoremap <C-U> 11kzz
		" nnoremap H 22kzz
		" nnoremap { {zz
		" nnoremap k kzz
		" nnoremap # #zz
		" nnoremap N Nzz
		" nnoremap j jzz
		" nnoremap } }zz
		" nnoremap L 22jzz
		" nnoremap <C-D> 11jzz
		" " nnoremap <C-F> 22jzz " This is mapped to the fzf plugin
		" nnoremap n nzz
		" nnoremap * *zz
		" nnoremap G Gzz
		" nnoremap '. '.zz
		" nnoremap '' ''zz
		" nnoremap % %zz
		" nnoremap dd ddzz
" }}}
" Plugins {{{
	" vim-plug {{{
		" Automatically install Vim-plug (if notalready installed):
		if empty(glob('~/.vim/autoload/plug.vim'))
			silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		endif
			
		" Enter "Plug 'githubUser/repositoryName'", 
		" Save this file, re-open vim and run ':PlugInstall'
		" Run ':PlugUpgrade' and ':PlugUpdate' whenever you want
		" To remove a plugin, remove from this list, save and run ':PlugClean'
		call plug#begin('~/.vim/plugged')
		Plug 'junegunn/vim-plug' " Vim-plug itself, to enable its Vim help.
		Plug 'morhetz/gruvbox' " Beautiful colors =]
		Plug 'preservim/nerdtree' " Tree explorer
		" Plug 'Xuyuanp/nerdtree-git-plugin' " Show file status on NERDTree THIS SHIT MAKES EVERYTHING SLOW WHEN THE PROJECT FOLDER IS BIG!
		Plug 'ryanoasis/vim-devicons' " Icons for NERDTree.
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Colors based on filetype NOT WORKING!!!!!
		Plug 'jiangmiao/auto-pairs' " Create the closing bracket automatically {}[]()
		Plug 'scrooloose/syntastic' " Correct syntax error automatically when saving.
		Plug 'tpope/vim-surround' " Delete, change, add surroundings easily.
		Plug 'tpope/vim-commentary' " Comment stuff out
		Plug 'Yggdroot/indentLine' " Visually display indent levels.
		Plug 'michaeljsmith/vim-indent-object' " Select a block with same indentation.
		Plug 'vim-airline/vim-airline' " Status line (tab line)
		Plug 'enricobacis/vim-airline-clock' " For fullscreen vim sessions
		Plug 'vim-airline/vim-airline-themes' " Beautiful themes =]
		Plug 'neoclide/coc.nvim', {'branch':'release'} " Conquer of Completion
		Plug 'tpope/vim-fugitive' " Use git inside vim!
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Command-line fuzzy finder
		Plug 'junegunn/fzf.vim'
		Plug 'airblade/vim-gitgutter' " Shows git diff markers in the sign column.
		Plug 'wesQ3/vim-windowswap' " Swap windows without ruining layout
		Plug 'tpope/vim-repeat' " Remaps '.' in a way that works with plugins
		Plug 'tpope/vim-obsession' " Continuously updated session files
		Plug 'mattn/emmet-vim' " Expand HTML abbreviations
		" Plug 'prettier/vim-prettier', {'do': 'yarn install' } " Make code prettier =]
		Plug 'moll/vim-bbye' " Deleting a buffer without closing the window
		Plug 'tpope/vim-haml' " Vim runtime for Haml, Sass, ans SCSS
		" Plug 'terryma/vim-multiple-cursors' " Multiple cursors
		Plug 'jeetsukumaran/vim-buffergator' " Easily browse through buffer list
		Plug 'maxmellon/vim-jsx-pretty' " Syntax for jsx (for React development)
		Plug 'lervag/vimtex' " filetype plugin for LaTeX files
		" Plug 'diepm/vim-rest-console' " Send HTTP requests directly from VIM
		call plug#end()
	" }}}
	" gruvbox {{{
		" Correct colors due to xfce terminal
		set termguicolors
		let g:gruvbox_contrast_dark='hard'
		set background=dark
		colorscheme gruvbox
	" }}}
	" vim-airline {{{
		" Download the font DeJaVuSansMono Nerd Font, place it in ~/.local/share/fonts
		" Change the terminal font to that font.
		" Display tabline
		let g:airline#extensions#tabline#enabled = 1 
		let g:airline#extensions#tabline#left_sep = ' '
		let g:airline#extensions#tabline#left_alt_sep = '|'
		let g:airline#extensions#tabline#formatter = 'unique_tail'

		" Tabs in the tabline:
		let g:airline#extensions#tabline#show_tabs = 1 " Regardless of number of open tabs
		let g:airline#extensions#tabline#show_tab_count = 2 " Always display tab number

		" Buffers in the tabline:
		let g:airline#extensions#tabline#buffer_idx_mode = 3 " Show indexes and map <leader># to go to #th buffer

		nmap <leader>01 <Plug>AirlineSelectTab01
		nmap <leader>02 <Plug>AirlineSelectTab02
		nmap <leader>03 <Plug>AirlineSelectTab03
		nmap <leader>04 <Plug>AirlineSelectTab04
		nmap <leader>05 <Plug>AirlineSelectTab05
		nmap <leader>06 <Plug>AirlineSelectTab06
		nmap <leader>07 <Plug>AirlineSelectTab07
		nmap <leader>08 <Plug>AirlineSelectTab08
		nmap <leader>09 <Plug>AirlineSelectTab09
		nmap <leader>11 <Plug>AirlineSelectTab11
		nmap <leader>12 <Plug>AirlineSelectTab12
		nmap <leader>13 <Plug>AirlineSelectTab13
		nmap <leader>14 <Plug>AirlineSelectTab14
		nmap <leader>15 <Plug>AirlineSelectTab15
		nmap <leader>16 <Plug>AirlineSelectTab16
		nmap <leader>17 <Plug>AirlineSelectTab17
		nmap <leader>18 <Plug>AirlineSelectTab18
		nmap <leader>19 <Plug>AirlineSelectTab19
		nmap <leader>- <Plug>AirlineSelectPrevTab
		nmap <leader>+ <Plug>AirlineSelectNextTab


		" vim-airline-theme
		let g:airline_theme='badwolf' 

		" " Integrate with vim-obsession (Prepend a '$' when enabled)
		" function! AirlineInit()
		" 	let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
		" endfunction
		" autocmd User AirlineAfterInit call AirlineInit()
	" }}}
	" vim-airline-clock {{{
		" disable:
		let g:airline#extensions#clock#auto = 0 
	" }}}
	" nerdtree {{{
		" Resize terminal window
		" autocmd VimEnter * exe "resize " . (winheight(0) * 40/100)

		" Open NERDTree if no file is given as CLI argument
		autocmd StdinReadPre * let s:std_in=1
		autocmd VimEnter * NERDTreeFocus

		" Show hidden files
		let g:NERDTreeShowHidden = 1

		" Ignore swap files
		let NERDTreeIgnore=['\.swp$[[file]]']

		" Close the tree window automatically after opening a file
		let g:NERDTreeQuitOnOpen = 3
		let g:NERDTreeWinSize = 30
		let g:NERDTreeWinSizeMax = 80

		" Indicate changes in files that have a git version control
		let g:NERDTreeGitStatusWithFlags=1	
		let g:WebDevIconsUnicodeDecorateFolderNodes=1
		let g:NERDTreeGitStatusNodeColorization=1

		" Sync open file with NERDTree {{{
			" (THERE IS A BUG WHEN NERDTREE HAS NOT BEEN ALREADY LOADED, IT OPENS 2 
			" INSTANCES... THAT'S WHY I DEACTIVATED...)
			" function! IsNERDTreeOpen()
			" 	return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
			" endfunction
			"
			" " Call NERDTree iff NERDTree is active, current window contains a 
			" " modifiable file, and we're not in vimdiff
			" function! SyncTree()
			" 	if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
			" 		NERDTreeFind
			" 		wincmd p
			" 	endif
			" endfunction
			"
			" Highlight currently open buffer in NERDTree 
			" autocmd BufEnter * call SyncTree()
		" }}}

		" Always show cursorline in NERDTree
		let g:NERDTreeHighlightCursorline=1

		" Automatically delete the buffer of the file you just deleted with NT
		let NERDTreeAutoDeleteBuffer = 1

		" Close vim if NERDTree is the last open window.
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

		" Do not open files/buffers on the NerdTree window: 
		" If more than one window and previous buffer was NERDTree, go back to it.
		autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
		let g:plug_window = 'noautocmd vertical topleft new' " Required to avoid crash on vim-plug calls when cursor is over NERDTree

		" Config specific for NERDTree
		" augroup nerdtree
			" autocmd!
			" autocmd FileType nerdtree syntax clear NERDTreeFlags
			" other nerdtree related autocmds
		" augroup END 
		 
	" }}}
	" vim-devicons {{{
		" Download the font DeJaVuSansMono Nerd Font, place it in ~/.local/share/fonts
		" The terminal font has to be also that NerdFont .
		set encoding=UTF-8
		let g:airline_powerline_fonts = 1
		set guifont=DejaVuSansMono\ Nerd\ Font\ Bold\ 9
	" }}}
	" vim-nerdtree-syntax-highlight {{{
			" " Disable highlightng
			" let g:NERDTreeDisableFileExtensionHighlight = 1
			" let g:NERDTreeDisableExactMatchHighlight = 1
			" let g:NERDTreeDisablePatternMatchHighlight = 1
			
			" " Reduce number of extensions to check (reduces lag)
			" let g:NERDTreeLimitedSyntax = 1
	" }}}
	" syntastic {{{
		" To add support for React (jsx, tsx), follow the instructions in: 
		" https://github.com/jaxbot/syntastic-react
		set statusline+=%#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*
		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_auto_loc_list = 0 " Don't auto open/close location list
		let g:syntastic_check_on_open = 0
		let g:syntastic_check_on_wq = 0
		let g:syntastic_mode="passive"
		" let g:syntastic_enable_signs=0
		let g:syntastic_html_checkers=['w3']
		let g:syntastic_javascript_checkers=['eslint']
		let g:syntastic_typescript_checkers=['eslint']
		let g:syntastic_python_python_exec = 'python3'
		let g:syntastic_python_checkers = ['pylint', 'python', 'flake8', 'pyflakes']
		nnoremap <F7> :SyntasticCheck<CR> :lopen<CR>
	" }}}
	" indentLine {{{
		let g:indentLine_color_term = 2
		let g:indentLine_setConceal = 0
	" }}}
	" Conquers of Completion (CoC) {{{ 
		" I had to manually install each CoC extension using 'npm install <extension>'
		"	npm install coc-tsserver (for javascript and typescript)
		"	npm install coc-vimlsp (for vim language)
		"	npm install coc-eslint (lint javascript files)
		"	npm install coc-spell-checker
		"	npm install coc-snippets (create custom snippets to insert patterns)
		"	npm install coc-python 
		"	npm install coc-markdownlint
		"	npm install coc-json
		"	npm install coc-html
		"	npm install coc-css (for css, scss and less)
		"	npm install coc-clangd (for C/C++/Objective-C)
		
		" Trying to give the path to a newer version of node
		let g:coc_node_path='~/Downloads/node-v14.2.0-linux-x64/bin/node'
		
		" Dically install desired extensions
		let g:coc_global_extensions = [
		\ 'coc-tsserver',
		\ 'coc-tslint-plugin',
		\ 'coc-vimlsp',
		\ 'coc-eslint',
		\ 'coc-snippets',
		\ 'coc-python',
		\ 'coc-markdownlint',
		\ 'coc-json',
		\ 'coc-html',
		\ 'coc-css',
		\ 'coc-clangd',
		\ 'coc-emmet',
		\ 'coc-prettier',
		\ 'coc-vimtex',
		\ 'coc-spell-checker',
		\ 'coc-cspell-dicts',
		\ ]
		
		" Some servers have issues with backup files, see #649.
		set nobackup
		set nowritebackup

		" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
		" delays and poor user experience.
		set updatetime=300
		 
		" avoid update the screen before coc is ready
		" set lazyredraw

		" Don't pass messages to |ins-completion-menu|.
		set shortmess+=c

		" Always show the signcolumn, otherwise it would shift the text each time
		" diagnostics appear/become resolved.
		set signcolumn=yes

		" Use tab for trigger completion with characters ahead and navigate.
		" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
		" other plugin before putting this into your config.
		inoremap <silent><expr> <TAB>
			  \ pumvisible() ? "\<C-n>" :
			  \ <SID>check_back_space() ? "\<TAB>" :
			  \ coc#refresh()
		inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

		function! s:check_back_space() abort
		  let col = col('.') - 1
		  return !col || getline('.')[col - 1]  =~# '\s'
		endfunction

		" Use <c-space> to trigger completion. My terminal sends <NUL> instead of
		" <c-space>, so...
		" inoremap <silent><expr> <c-space> coc#refresh()
		inoremap <silent><expr> <NUL> coc#refresh()

		" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
		" position. Coc only does snippet and additional edit on confirm.
		" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
		if exists('*complete_info')
		  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
		else
		  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
		endif

		" Use `[g` and `]g` to navigate diagnostics
		nmap <silent> [g <Plug>(coc-diagnostic-prev)
		nmap <silent> ]g <Plug>(coc-diagnostic-next)

		" GoTo code navigation.
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)

		" Use K to show documentation in preview window.
		nnoremap <silent> K :call <SID>show_documentation()<CR>

		function! s:show_documentation()
		  if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		  else
			call CocActionAsync('doHover')
		  endif
		endfunction

		" Highlight the symbol and its references when holding the cursor.
		autocmd CursorHold * silent call CocActionAsync('highlight')

		" Symbol renaming.
		nmap <leader>rn <Plug>(coc-rename)

		" Formatting selected code.
		xmap <leader>f  <Plug>(coc-format-selected)
		nmap <leader>f  <Plug>(coc-format-selected)

		" Custom behaviour for specific group of filetypes:
		" augroup mygroup
		"   autocmd!
		"   " Setup formatexpr specified filetype(s).
		"   autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
		"   " Update signature help on jump placeholder.
		"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
		" augroup end

		" Applying codeAction to the selected region.
		" Example: `<leader>aap` for current paragraph
		xmap <leader>a  <Plug>(coc-codeaction-selected)
		nmap <leader>a  <Plug>(coc-codeaction-selected)

		" Remap keys for applying codeAction to the current line.
		nmap <leader>ac  <Plug>(coc-codeaction)
		" Apply AutoFix to problem on the current line.
		nmap <leader>qf  <Plug>(coc-fix-current)

		" Introduce function text object
		" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
		xmap if <Plug>(coc-funcobj-i)
		xmap af <Plug>(coc-funcobj-a)
		omap if <Plug>(coc-funcobj-i)
		omap af <Plug>(coc-funcobj-a)

		" Use <TAB> for selections ranges.
		" NOTE: Requires 'textDocument/selectionRange' support from the language server.
		" coc-tsserver, coc-python are the examples of servers that support it.
		nmap <silent> <TAB> <Plug>(coc-range-select)
		xmap <silent> <TAB> <Plug>(coc-range-select)

		" Add `:Format` command to format current buffer.
		command! -nargs=0 Format :call CocActionAsync('format')

		" Add `:Fold` command to fold current buffer.
		command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

		" Add `:OR` command for organize imports of the current buffer.
		command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

		" Mappings using CoCList:
		" Show all diagnostics.
		nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
		" Manage extensions.
		nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
		" Show commands.
		nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
		" Find symbol of current document.
		nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
		" Search workspace symbols.
		nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
		" Do default action for next item.
		nnoremap <silent> <space>j  :<C-u>CocNext<CR>
		" Do default action for previous item.
		nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
		" Resume latest coc list.
		nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
	" }}}
	" fzf {{{
		" map <C-f> <Esc><Esc>:Files!<CR>
		" inoremap <C-f> <Esc><Esc>:BLines!<CR>
		" map <C-g> <Esc><Esc>:BCommits!<CR>
	" }}}
	" vim-windowswap {{{
		" Instructions: 
		"	navigate to one window
		"	press <leader>ww
		"	navigate to another window
		"	press <leader>ww
	" }}}
	" vim-obsession {{{
		" If no session exists, create a new session automatically. If exists,
		" load it. ------- UPDATE: It was not working properly with the terminal
		" and coc.nvim was not reloading also.
		" autocmd VimEnter * if empty(glob("Session.vim")) | Obsession Session.vim | else | source Session.vim | endif

		" Set the vim terminal window to the saved size and position.
		set sessionoptions+=resize
		set sessionoptions+=winpos
		set sessionoptions-=options
	" }}}
	" emmet-vim {{{
		" Tutorial: position the cursor after the html abbreviation, and press 
		" (ctrl+Y+,)
		
		" Enable just for HTML/CSS
		let g:user_emmet_install_global=0
		autocmd FileType html,css EmmetInstall

		" To remap the default <C-Y> leader:
		" let g:user_emmet_leader_key='<C-Z>'
		" Note that the trailing , still needs to be entered after <C-Z>
	" }}}
	" vimTex {{{
		let g:tex_flavor = 'latex'
	" }}}
	" vim-prettier {{{
		" prettier encountered an error during instalation (I think node/yarn
		" related), so I had to manually run 'npm install' inside the
		" vim-prettier directory, and it started working.
		 " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
	" }}}
	" vim-multiple-cursors {{{
		" " Remap the original bindings
		" let g:multi_cursor_use_default_mapping=0 
		" let g:multi_cursor_start_word_key      = '<C-c>'
		" let g:multi_cursor_select_all_word_key = 'c' " <A-c>
		" let g:multi_cursor_start_key           = 'g<C-c>'
		" let g:multi_cursor_select_all_key      = 'gc' " g<A-c>
		" let g:multi_cursor_next_key            = '<C-c>'
		" let g:multi_cursor_prev_key            = '<C-p>'
		" let g:multi_cursor_skip_key            = '<C-x>'
		" let g:multi_cursor_quit_key            = '<Esc>'
	" }}}
	" vim-bbye {{{
		nnoremap <Leader>q :Bdelete<CR>
	" }}}
	" vim-gitgutter {{{
		" Disabled by default
		let g:gitgutter_enabled = 0
	" }}}
 " }}} 
