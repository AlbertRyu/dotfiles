-- The leader key is set to be <space>. This has to be before any plugin using it.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.tex_flavor = "latex" -- I only write Latex by far.

vim.o.exrc = true -- Allow project level .lua file.

require("config.lazy")
require("config.core")
require("config.keymap")
require("config.beancount")
