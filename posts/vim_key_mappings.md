# Vim Key Mappings

## Objective
Show useful builtin and custom keyboard shortcuts.

## Table of Contents
- [Mapping Keys](#mapping-keys)
- [Key Commands](#key-commands)

## Mapping Keys
### map vs \<...\>map
- The below example will cause an infinite recursive process \
  because when x is pressed it will be mapped to y and then \
  the next map will do the opposite.
  ```vim
  map x y
  map y x
  ```

- The below example will cause a non-recursive process so an \
  infinite recursive process will not occur and the mappings \
  will only apply once.
  ```vim
  noremap x y
  noremap y x
  ```

- The following characters at the beginning of map and noremap for example \
  the character `i` correspond to specific modes in vim. Running \
  `:help map` in vim will provide the following:
  ```txt
       COMMANDS                    MODES ~
  :map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
  :nmap  :nnoremap :nunmap    Normal
  :vmap  :vnoremap :vunmap    Visual and Select
  :smap  :snoremap :sunmap    Select
  :xmap  :xnoremap :xunmap    Visual
  :omap  :onoremap :ounmap    Operator-pending
  :map!  :noremap! :unmap!    Insert and Command-line
  :imap  :inoremap :iunmap    Insert
  :lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
  :cmap  :cnoremap :cunmap    Command-line
  :tmap  :tnoremap :tunmap    Terminal
  ```

- Some helpful mappings include:
  ```vim
  " NOTE: <leader> corresponds to `\` in linux and <c-h> corresponds to
  " `ctrl + h`
  " Force use of hjkl-style movement and pageup(c-b)/pagedown(c-f)
  map <up> <nop>
  map <down> <nop>
  map <left> <nop>
  map <right> <nop>
  map <pageup> <nop>
  map <pagedown> <nop>
  map <home> <nop>
  map <end> <nop>

  imap <up> <nop>
  imap <down> <nop>
  imap <left> <nop>
  imap <right> <nop>
  imap <pageup> <nop>
  imap <pagedown> <nop>
  imap <home> <nop>
  imap <end> <nop>

  " Command line mode without shift+:
  noremap ; :

  " Faster split window navigation
  noremap <c-h> <c-w><c-h>
  noremap <c-j> <c-w><c-j>
  noremap <c-k> <c-w><c-k>
  noremap <c-l> <c-w><c-l>

  " Search word under cursor
  nnoremap <leader>w :grep! "\b<c-r><c-w>\b"<cr>:cw<cr>

  " Mappings for quickfix list
  nmap <silent> <c-n> :cn<cr>zv
  nmap <silent> <c-p> :cp<cr>zv

  " Remove highlight after search
  nnoremap <leader>h :nohls<cr>

  " Buffer Mappings
  nnoremap <leader>b :buffers<cr>:buffer<space>
  nnoremap <leader>t :e#<cr>
  ```

## Key Commands
### Character search
- Move to char: `f[char]`
- Move back to char: `F[char]`
- Move before char: `f[char]`
- Move back before char: `F[char]`
- Repeat char search forward/back: `;`/`,`

### Mark text
- Text Objects: `v` + p,w,s,[,(,{,<,',",\`
- Text Inner Objects: `vi` + p,w,s,[,(,{,<,',",\`
- Note: p = paragraph, w = word, s = sentence

### Modify during insert mode
- Delete character before cursor: `ctrl + h`
- Delete word before cursor: `ctrl + w`
- Indent once right: `ctrl + t`
- Indent once left: `ctrl + d`
- Insert contents of register (a-z): `ctrl + r\<register\>`
- Enter normal mode to issue one command only: `ctrl + o\<command\>`

### Move back/forward in file one full screen
- Up: `ctrl + b`
- Down: `ctrl + f`

### Change occurrences of a word
- `*`
- `cw`
- Type new word
- `esc`
- `n`
- `.`
- Repeat `n` then `.`

### Change/Delete inside \<x\>=(,{,w,...
- Change: `ci\<x\>`
- Delete: `di\<x\>`
