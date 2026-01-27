
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary.nvim" }, -- required
  { src = "https://github.com/nvim-telescope/telescope.nvim", name = "telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", name = "telescope-fzf-native.nvim" },
})

vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("telescope.nvim")
vim.cmd.packadd("telescope-fzf-native.nvim")

-- Load extension (pcall so it won't explode if not built yet)
local telescope = require("telescope")
local builtin = require("telescope.builtin")
pcall(telescope.load_extension, "fzf")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = "❯ ",
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
    -- Optional: less noise in paths
    path_display = { "smart" },
  },
})


