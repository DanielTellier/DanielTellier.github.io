# Vim Folder Structure

## Objective
Explain some of vim's less obvious configuration folders.

## Table of Contents
- [after](#after)
- [autoload](#autoload)
- [compiler](#complier)
- [ftplugin](#ftplugin)

## after
- Place specific vim folders such as ftplugin or compiler.
- Taking the ftplugin as an example:
  - Creating the following file: after/ftplugin/c.vim
    - Any settings you put in the above c.vim will overwrite the default  
    c.vim (usually for linux at: /usr/share/vim/ftplugin/c.vim) but will  
    retain all other settings in the default file.

## autoload
- Define functions that the user wants to be loaded only once. Furthermore,  
  these functions are only loaded when called and not loaded again until  
  vim is closed and the function is called once again.
- The autoload feature is usually used for functions in large plugins  
  where these functions are not necessary on vim startup.

## compiler
- Extend certain compilers features such as gcc.
- An example could extract the error messages from gcc and take you  
  to each error at the exact location in each file.

## ftplugin
- Creating the file ftplugin/c.vim will only take settings from this file  
  and will completely ignore the default c.vim file. As mentioned above  
  the default files for linux are usually at /usr/share/vim/ftplugin/\*.vim.

