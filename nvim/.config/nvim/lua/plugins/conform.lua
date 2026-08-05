return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			tex = { "tex-fmt" },
			beancount = { "bean-format" },
			python = { "ruff_format" },
			markdown = { "mdformat" },
			fish = { "fish_indent" },
			cpp = { "clang_format" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		-- set automatic format after save(:w)
		vim.api.nvim_create_autocmd("BufWritePre", { --fire this auto command when "BufWritePre" is fired.
			pattern = "*", -- applys to any file.
			callback = function(args) -- the content of the command.
				require("conform").format({ bufnr = args.buf }) -- args.buf is the id of saved buffer.
			end,
		})
	end,
}
