-- This file inlucdes three plugins
-- Mason : LSP Manager
-- nvim-lspconfig : includes all the configurations for the LSPs to NVIM
-- mason-lspconfig : connected the above two
return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		-- Harper-ls as daily English language LSP, ltex_plus is reserved for more serious
		-- documents. So automatic enable is excluded.
		automatic_enable = {
			exclude = { "ltex_plus" },
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function(_, opts)
		-- Additional set up for platformio
		vim.lsp.config("clangd", {
			cmd = {
				vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
				"--query-driver=/Users/yunxiao/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-*",
				"--background-index",
				"--pch-storage=memory",
				"--header-insertion=never",
			},
		})

		-- Additional set up for Harper-ls, put user dictionary inside the dotfiles so it is elegantly synchronized and backed up across machines.
		vim.lsp.config("harper_ls", {
			-- filetypes = { "markdown", "tex", "plaintex", "gitcommit", "text" },
			settings = {
				["harper-ls"] = {
					userDictPath = vim.fn.expand("~/.config/nvim/spell/harper.txt"),
					isolateEnglish = true,
					dialect = "American",
				},
			},
		})

		require("mason-lspconfig").setup(opts)
	end,
}
