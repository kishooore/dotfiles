vim.g.mapleader = ' '

local o  = vim.o
local wo = vim.wo
local bo = vim.bo

o.termguicolors     = true
o.splitright        = true
o.splitbelow        = true
o.background        = 'dark'
o.hlsearch          = false
o.incsearch         = true
o.guicursor         = ''
o.completeopt	    = 'menu,menuone,noselect'
o.updatetime	    = 300

bo.expandtab        = true
bo.autoindent       = true
bo.cindent          = true
bo.softtabstop      = 2
bo.tabstop	    = 2
bo.shiftwidth	    = 2


wo.signcolumn       = 'yes'
wo.number           = true
wo.relativenumber   = true

vim.cmd 'syntax on'
vim.cmd 'hi Normal ctermbg=none'
vim.cmd 'highlight NonText ctermbg=none'
vim.cmd 'set shortmess+=c'
vim.cmd 'filetype indent on'
vim.cmd 'set nocompatible'
vim.cmd 'set colorcolumn=80'
vim.cmd 'set clipboard+=unnamedplus'
