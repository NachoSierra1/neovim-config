return{
	{
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		'windwp/nvim-autopairs'

    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup({})
		local npairs = require('nvim-autopairs')
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
			window = {
				documentation = cmp.config.window.bordered(),
				completion = cmp.config.window.bordered(),
				},
            completion = { completeopt = "menu,menuone,noinsert" },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete({}),
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
				["<C-e>"] = cmp.mapping.abort(),
            }),
            sources = {
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip", priority = 500},
                { name = "path",
				  option = {
						trailing_slash = true,
					},
				priority = 250	},
				{ name = "buffer",
				option = {
      				get_bufnrs = function()
        			return vim.api.nvim_list_bufs()
      			end,
    				},
				priority = 750
				},
            },
        })

		cmp.setup.cmdline({ '/', '?'}, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{name = 'buffer'}
				}

			})
		cmp.event:on('confirm_done',
			cmp_autopairs.on_confirm_done()
			)



    end,
}


}
