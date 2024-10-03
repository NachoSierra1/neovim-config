local keymap = vim.keymap.set

keymap("i", "{", "{}<Left>", { noremap = true, silent = true})
keymap("i", "(", "()<Left>", { noremap = true, silent = true})
keymap("i", "[", "[]<Left>", { noremap = true, silent = true})
keymap("i", "'", "''<Left>", { noremap = true, silent = true})
keymap("i", '"', '""<Left>', { noremap = true, silent = true})
keymap("i", "<", "<><Left>", { noremap = true, silent = true})

keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

keymap("n", "<leader>pv", ":Ex<CR>", { noremap = true, silent = true })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap("i", "jk", "<Esc>")

local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<leader>fg', builtin.live_grep, {})
keymap('n', '<leader>fb', builtin.buffers, {})
keymap('n', '<leader>fh', builtin.help_tags, {})

-- Horizontal split
keymap('n', '<leader>sh', ':split<CR>')
keymap('n', '<leader>sv', ':vsplit<CR>')

-- Resize splits
keymap('n', '<leader>+', ':resize +2<CR>')
keymap('n', '<leader>-', ':resize -2<CR>')
keymap('n', '<leader>>', ':vertical resize +2<CR>')
keymap('n', '<leader><', ':vertical resize -2<CR>')

-- Move between splits
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

keymap('n', '<leader>rp', '<cmd>split | terminal py %<CR>')
keymap('n', '<leader>rn', '<cmd>split | terminal node %<CR>')

local cmp = require("cmp")
local luasnip = require('luasnip')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
				end
			else
				fallback()
			end
		end),
		["<Tab>"] = cmp.mapping(function(fallback)
			-- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				end
				cmp.confirm()
			else
				fallback()
			end
		end, {"i","s","c",}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- ... Your other mappings ...
	}),
})
