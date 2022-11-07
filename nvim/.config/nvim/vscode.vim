imap jk <Esc>
map s gr
nmap ss grr
map S gr$
map L $
map H ^

omap ai aI

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

noremap <C-U> Hzz
noremap <C-d> Lzz

map <CR> editor.action.smartSelect.expand
map <bs> editor.action.smartSelect.shrink

" 显示悬停信息
noremap K :vsc editor.action.showHover<CR>

" noremap <tab> :vsc workbench.action.nextEditor<CR>
" noremap <S-tab> :vsc workbench.action.previousEditor<CR>

" 多光标
noremap <C-n>  editor.action.addSelectionToNextFindMatch
vnoremap <C-x>  editor.action.moveSelectionToNextFindMatch

" fold
noremap z1 editor.foldLevel1
noremap z2 editor.foldLevel2
noremap z3 editor.foldLevel3
noremap z4 editor.foldLevel4
noremap z5 editor.foldLevel5
noremap z6 editor.foldLevel6
noremap z7 editor.foldLevel7
noremap zj editor.gotoNextFold
noremap zk editor.gotoPreviousFold
noremap zp editor.gotoParentFold
noremap zm :vsc dakara-foldplus.levelAtCursor<CR>
noremap zr :vsc dakara-foldplus.levelAtCursor.unfold<CR>

noremap <space> :vsc whichkey.show<CR>

noremap <C-m> :vsc workbench.action.minimizeOtherEditors<CR>

noremap gB :vsc selectAllSearchEditorMatches<CR>
noremap ga :vsc extension.alignTokens<CR>
" 打开侧边定义
noremap gi :vsc editor.action.goToImplementation<CR>
noremap gd :vsc editor.action.goToDeclaration<CR>
noremap gD :vsc editor.action.revealDefinitionAside<CR>
noremap gp :vsc references-view.showSupertypes<CR>
" noremap gr :vsc editor.action.goToReferences<CR>

noremap B :enew<cr>

noremap ]h /<template<cr>
noremap ]H /<\/template<cr>
noremap ]s /<script<cr>
noremap ]S /<\/script<cr>
noremap ]c /<style<cr>
noremap ]C /<\/style<cr>
