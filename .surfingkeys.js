// Compatibility Prefix
const {
  Clipboard,
  Front,
  Hints,
  Normal,
  RUNTIME,
  Visual,
  aceVimMap,
  addSearchAlias,
  cmap,
  getClickableElements,
  imap,
  imapkey,
  iunmap,
  map,
  mapkey,
  readText,
  removeSearchAlias,
  tabOpenLink,
  unmap,
  unmapAllExcept,
  vmapkey,
  vunmap,
} = api;
// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
map("gt", "T");

map("<Tab>", "R");
map("<Shift-Tab>", "E");

settings.theme = `
:root {
    --theme-ace-bg:#282828; /*Note the fourth channel, this adds transparency*/
    --theme-ace-bg-accent:#3c3836;
    --theme-ace-fg:#ebdbb2;
    --theme-ace-fg-accent:#7c6f64;
    --theme-ace-cursor:#928374;
    --theme-ace-select:#458588;
}
#sk_editor {
    height: 50% !important; /*Remove this to restore the default editor size*/
    background: var(--theme-ace-bg) !important;
}
.ace_dialog-bottom{
    border-top: 1px solid var(--theme-ace-bg) !important;
}
.ace-chrome .ace_print-margin, .ace_gutter, .ace_gutter-cell, .ace_dialog{
    background: var(--theme-ace-bg-accent) !important;
}
.ace-chrome{
    color: var(--theme-ace-fg) !important;
}
.ace_gutter, .ace_dialog {
    color: var(--theme-ace-fg-accent) !important;
}
.ace_cursor{
    color: var(--theme-ace-cursor) !important;
}
.normal-mode .ace_cursor{
    background-color: var(--theme-ace-cursor) !important;
    border: var(--theme-ace-cursor) !important;
}
.ace_marker-layer .ace_selection {
    background: var(--theme-ace-select) !important;
}

.sk_theme {
	background: #303446;
    color: #8CAAEE;
    font-size:16px;
}
.sk_theme tbody {
	color: #98BB6C;
}
.sk_theme .title {
    padding:3px 0;
    font-weight: bold;
}
.sk_theme input {
	color: #c6d0f5	;
}
.sk_theme .url {
    margin-top:3px;
    padding:3px 0;
    color: #F2D5CF;
}
.sk_theme .omnibar_timestamp{
    color: #c6d0f5	;
    font-weight: normal;
}
.sk_theme .omnibar_folder{
    color: #EF9F76;
    font-weight: normal;
}
.sk_theme .annotation {
	color: #957FB8;
}
.sk_theme .omnibar_highlight {
    color: #A6D189;
    font-weight: bold;
	background: #303446;
}
.sk_theme #sk_omnibarSearchResult ul>li {
    padding: 10px;
    border-bottom: 1px solid #414559;
}
.sk_theme #sk_omnibarSearchResult ul>li:nth-child(odd) {
	background: #303446;
}
.sk_theme #sk_omnibarSearchResult ul>li.focused {
	background: #575D75	;
}

`;
