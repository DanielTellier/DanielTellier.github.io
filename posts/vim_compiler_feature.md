# Vim Compiler Feature

## Objective
Show how to use vim's compiler feature.

## Table of Contents
- [Compiler Feature](#compiler-feature)

## Compiler Feature
- Setup make in vim for c language (can be applied to any language) \
to go to files that contain errors within quickfix list.

- Place in $VIMHOME/compiler/c.vim:
```vim
let current_compiler = 'c'
CompilerSet makeprg=make
CompilerSet errorformat=%E%f:%l:%c:%m
```

- Place in $VIMHOME/after/ftplugin/c.vim:
```vim
compiler c
```

- Now you can run `make` in vim command mode ergo `:make`:
    - The above will open the first file found with an error and take \
    you directly to the line with the issue.
    - You can go to the next error if there is one with :cn or you can \
    go to the previous with :cp.
