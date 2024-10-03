return {	
	{
		'neovim/nvim-lspconfig',
	},
	{	
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'petertriho/cmp-git',
			'onsails/lspkind.nvim',
			{

				'windwp/nvim-autopairs',
				event = "InsertEnter",
				config = true,
				opts = {
					enable_check_bracket_line = false,
				},
			},
		},

		config = function()
			local cmp = require("cmp")
			local lspkind = require('lspkind')
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local kind_icons = {
				Text = "📄",        -- Documento
				Method = "🔧",      -- Herramienta
				Function = "🔨",    -- Martillo
				Constructor = "🚧", -- Construcción
				Field = "🌾",       -- Campo
				Variable = "🔑",    -- Llave
				Class = "🏛",       -- Edificio clásico
				Interface = "🌉",   -- Puente
				Module = "📦",      -- Caja de paquete
				Property = "🏠",    -- Casa
				Unit = "📏",        -- Regla
				Value = "💰",       -- Dinero
				Enum = "🔢",        -- Números
				Keyword = "🔑",     -- Llave
				Snippet = "✂️",     -- Tijeras
				Color = "🎨",       -- Paleta de colores
				File = "📁",        -- Carpeta
				Reference = "🔗",   -- Enlace
				Folder = "📂",      -- Carpeta abierta
				EnumMember = "🔢",  -- Números
				Constant = "🅾️",    -- Círculo con O
				Struct = "🏗",      -- Estructura
				Event = "🎉",       -- Evento
				Operator = "➕",    -- Suma
				TypeParameter = "🔠", -- Letras
			}
			
			cmp.setup({
				enabled = function()
					-- disable completion in comments
					local context = require 'cmp.config.context'
					-- keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == 'c' then
						return true
					else
						return not context.in_treesitter_capture("comment") 
							and not context.in_syntax_group("Comment")
					end
				end,

				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lua" },
					{ name  = "buffer"},
					{ name = "latex_symbols" },
					{ name = "path" },

				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol_text', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters
						ellipsis_char = '...', -- when popup exceeds maxwidth
						show_label_details = true, -- show label details in menu
						before = function(entry, vim_item)
							-- Custom logic before display
							vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
							vim_item.menu =({
								luasnip = "[Snippet]",
								buffer = "[Buffer]",
								path = "[Path]",
								nvim_lsp = "[LSP]",
								nvim_lua = "[Lua]",
								latex_symbols = "[LaTeX]",
							})[entry.source.name]
							return vim_item
						end,

					}),
					fields = {"kind", "abbr", "menu"},

				},

				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			})
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
						{ name = 'buffer' },
					})
			})
			require("cmp_git").setup()

			cmp.setup.cmdline({"/", "?"}, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" }, -- Corrected placement here
				}),

				matching = { disallow_symbol_nonprefix_matching = false }
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
						{ name = 'cmdline' }
					}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local servers = { 'html', 'ts_ls', 'cssls', 'pyright', 'jsonls' }
			for _, server in ipairs(servers) do 
				require("lspconfig")[server].setup {
					capabilities = capabilities,
				}
			end

		end,

	}
}

