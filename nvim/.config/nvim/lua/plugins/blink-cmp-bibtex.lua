return {
	"saghen/blink.cmp",
	dependencies = {
		"krissen/blink-cmp-bibtex",
	},
	opts = {
		sources = {
			default = { "bibtex" },
			providers = {
				bibtex = {
					module = "blink-cmp-bibtex",
					name = "BibTeX",
					min_keyword_length = 2,
					score_offset = 10,
					async = true,
					opts = {
						-- files = { vim.fn.expand("~/Documents/ThesisWriting/ref.bib") },
						-- provider-level overrides (optional)
					},
				},
			},
		},
	},
}
