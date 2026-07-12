-- The leader key is set to be <space>. This has to be before any plugin using it.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.core")
require("config.keymap")
require("config.beancount")
