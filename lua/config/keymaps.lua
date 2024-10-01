local keymap = vim.keymap.set

keymap("i", "{", "{}<Left>", { noremap = true, silent = true })
keymap("i", "(", "()<Left>", { noremap = true, silent = true })
keymap("i", "[", "[]<Left>", { noremap = true, silent = true })
keymap("i", "'", "''<Left>", { noremap = true, silent = true })
keymap("i", '"', '""<Left>', { noremap = true, silent = true })
keymap("i", "<", "<><Left>", { noremap = true, silent = true })
keymap("i", "$", "$$<Left>", { noremap = true, silent = true })

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
