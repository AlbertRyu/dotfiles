-- This file inlucdes three plugins
-- Mason : LSP Manager
-- nvim-lspconfig : includes all the configurations for the LSPs to NVIM
-- mason-lspconfig : connected the above two
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
}
