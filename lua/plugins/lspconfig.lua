return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')	
		local servers = { "pyright", "ts_ls", "html", "cssls", "jsonls" }
		for _, server in ipairs(servers) do
			lspconfig[server].setup({})
		end
		---
		-- Keybindings
		---

		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function()
				local bufmap = function(mode, lhs, rhs)
					local opts = {buffer = true}
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
				bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
				bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
				bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
				bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
				bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
				bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
				bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
				bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
				bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
				bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
				bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
				bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
			end
		})

        
		---
		-- Diagnostics
		---

		local sign = function(opts)
			vim.fn.sign_define(opts.name, {
				texthl = opts.name,
				text = opts.text,
				numhl = ''
			})
		end

		sign({name = 'DiagnosticSignError', text = '✘'})
		sign({name = 'DiagnosticSignWarn', text = '▲'})
		sign({name = 'DiagnosticSignHint', text = '⚑'})
		sign({name = 'DiagnosticSignInfo', text = ''})

		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			float = {
				border = 'rounded',
				source = 'always',
			},
		})

		vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
			vim.lsp.handlers.hover,
			{border = 'rounded'}
		)

		vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{border = 'rounded'}
		)

		---
		-- LSP servers
		---

	 require('mason').setup({})
		 require('mason-lspconfig').setup({})

		local lspconfig = require('lspconfig')
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

		lspconfig.ts_ls.setup({
			capabilities = lsp_capabilities,
		})
		lspconfig.lua_ls.setup({
			capabilities = lsp_capabilities,
		})
		
	end
}
