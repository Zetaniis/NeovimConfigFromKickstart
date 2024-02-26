# My neovim config
First attempt at making neovim daily driver config. Work in progress. 
Based on:
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). 
- [which-key VsCode extension](https://marketplace.visualstudio.com/items?itemName=VSpaceCode.whichkey)
- [SpaceVim](https://spacevim.org/)

Using [lazy.nvim](https://github.com/folke/lazy.nvim) as a package manager. 

## Requirements
Run `:checkhealth` to see what's missing.

## File structure 

```
nvim
├───after
│   └───plugin - scripts sourced after lazynvim's setup 
└───lua
    ├───core - vim vanilla configs 
    └───plugins - plugins setup by lazynvim
```
