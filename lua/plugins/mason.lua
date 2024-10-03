return{
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				-- agregar los otros despues
			},
		},
	},
	"williamboman/mason-lspconfig.nvim",
}
