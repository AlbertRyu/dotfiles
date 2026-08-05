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
	config = function(_, opts)
		vim.lsp.config("clangd", {
			cmd = {
				vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
				"--query-driver=/Users/yunxiao/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-*",
				"--background-index",
				"--pch-storage=memory",
				"--header-insertion=never",
			},
		})
		require("mason-lspconfig").setup(opts)
	end,
}
