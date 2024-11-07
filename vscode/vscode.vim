noremap <space> :vsc whichkey.show<CR>

map s gr
nmap ss grr
map S gr$
map L $
map H ^

omap ai aI

noremap B :enew<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

map <CR> editor.action.smartSelect.expand
map <bs> editor.action.smartSelect.shrink

" 显示悬停信息
noremap K :vsc editor.action.showHover<CR>

" noremap <tab> :vsc workbench.action.nextEditor<CR>
" noremap <S-tab> :vsc workbench.action.previousEditor<CR>

" 多光标
noremap <C-n>  editor.action.addSelectionToNextFindMatch
vnoremap <C-x>  editor.action.moveSelectionToNextFindMatch


noremap <C-m> :vsc workbench.action.minimizeOtherEditors<CR>

" 打开侧边定义
" noremap gr :vsc editor.action.goToReferences<CR>
noremap gs :vsc editor.action.gotoreferences<CR>
noremap gi :vsc editor.action.goToImplementation<CR>
noremap gd :vsc editor.action.goToDeclaration<CR>
noremap gD :vsc editor.action.revealDefinitionAside<CR>
noremap gp :vsc references-view.showSupertypes<CR>
" noremap gi :vsc references-view.showIncomingCalls<CR>
" noremap go :vsc references-view.showOutgoingCalls<CR>

noremap ( :vsc workbench.action.moveEditorLeftInGroup<cr>
noremap ) :vsc workbench.action.moveEditorRightInGroup<cr>
noremap 15jzz
noremap 15kzz

noremap ]h /<template<cr>
noremap ]H /<\/template<cr>
noremap ]s /<script<cr>
noremap ]S /<\/script<cr>
noremap ]c /<style<cr>
noremap ]C /<\/style<cr>


noremap <leader>e :vsc workbench.view.explorer<CR>
noremap <leader>c :vsc workbench.action.closeActiveEditor<CR>
noremap <leader>w :vsc workbench.action.files.save<CR>
noremap <leader>h :nohlsearch<cr>
noremap <leader>f :vsc workbench.action.quickOpen<cr>
noremap <leader>m :vsc editor.action.formatDocument<cr>
noremap <leader>rd :%s/div/view/g
