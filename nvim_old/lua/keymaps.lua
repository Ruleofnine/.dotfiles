local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end
local harpoon = require("harpoon")
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
--terminal = require('nvim-terminal').DefaultTerminal;
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--Custom Keyboard Keybinds :)
-- map('n','<leader>x',':q!<CR>')
-- map('n','<leader>q',':wq<CR>')

map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<ESC>:w<CR>")
map("n", "<C-b>", ":bnext<CR>")
map("n", "<C-q>", ":Bdelete<CR>")
map("n", "<c-d>", ":split<CR>:lua vim.lsp.buf.definition()<CR>")
map("n", "<C-n>", ":Neotree toggle<cr>")
map("n", ";", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<C-/>", ":noh<CR>")
map("n", "<C-i>", function() harpoon:list():add() end)
map("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

-- Next diagnostic
map("n", "<C-p>", vim.diagnostic.goto_next)

-- Previous diagnostic
map("n", "<C-u>", function()
  vim.diagnostic.goto_prev()
  vim.diagnostic.open_float(nil, {focus = false})
 end, { desc = "Previous diagnostic" })

map("t", "<Esc>", "<C-\\><C-n>")
map("n", "<leader>f", ":lua vim.lsp.buf.format()<cr>")
map("n", "<leader>k", ":lua require('telescope.builtin').commands()<cr>")
map("n", "<leader>r", ":lua require('telescope.builtin').registers()<cr>")
map("n", "<leader>b", ":lua require('telescope.builtin').buffers()<cr>")
map("n", "<C-f>", ":lua require('telescope.builtin').live_grep()<cr>")
map("n", "<C-j>", ":lua require('telescope.builtin').find_files()<cr>")
-- map({"n","x","v"},"o","l")--move right
-- map({"n","x","v"},"e","k")--move up
-- map({"n","x","v"},"n","j")--move down
-- map({"n","x","v"},"y","h")--move left
-- map("n","<C-h>","<C-d>")--move half page down
-- map("n","<C-v>","<C-b>")--move one page up
-- map("n","<C-t>","<C-f>")--move one page down
-- map("n","<C-r>","<C-e>")--scroll text up
-- map("n","<C-j>","<C-y>")--scroll text down
-- map("n","Y","H")--move to top of screen
-- map("n","L","M")--move to middle of screen
-- map("n","O","L")--move to bottom of screen
-- map("n","d","w")--move to beginning of next word
-- map("n","D","W")--move to beginning of next word after a whitespace
-- map("n","v","b")--move to previous beginning of word
-- map("n","V","B")--move to beginning of previous word before a whitespace
-- map("n","r","e")--move to end of word
-- map("n","R","E")--move to end of word before a whitespace
-- map("n","gr","ge")--move to previous end of word
-- map("n","gR","gE")--move to previous end of word before a whitespace
-- map("n","zb","zt")--scroll the line with the cursor to the top
-- map("n","zv","zb")--scroll the line with the cursor to the bottom
-- map("n","u","i")--insert text before the cursor
-- map("n","U","I")--insert text before the first non-blank in the line
-- map("n","l","o")--begin a new line below the cursor and insert text
-- map("n","L","O")--begin a new line above the cursor and insert text
-- map("n","h","d")--del text under {motion}
-- map("n","H","D")--del to end of line
-- map("n","m","c")--change {motion} text (into register) and begin insert
-- map("n","M","C")--change to end of line
-- map("n","w","r")--replace current character
-- map("n","W","R")--replace character until esc
-- map({"n","x","v"},"j","y")--yank
-- map({"n","x","v"},"J","Y")--yank line
-- map("n",";","p")--put below current line
-- map("n",":","P")--put abowe current line
-- map("n","f","u")--undo
-- map({"n","x","v"},"k","n")--next matching search pattern
-- map({"n","x","v"},"K","N")--previous matching search pattern
-- map("n","t","f")--to next 'X' after cursor, in the same line (X is any character)
-- map("n","T","F")--to previous 'X' before cursor
-- map("n","b","t")--til next 'X' (similar to above, but cursor is before X)
-- map("n","B","T")--till previous 'X'
-- map({"n","x","v"},"i",";")--repeat above, in same direction
-- map("n","I",":")--repeat above, in reverse direction
-- map("n","c","v")--enter visual mode
-- map("n","<C-c>","<C-v>")--enter visual block mode
-- map("n","i",":")--enter command mode

