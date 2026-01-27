vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
    version = "main", -- important: use main if you want the new API
  },
})

-- load it into the current session
vim.cmd.packadd("nvim-treesitter")

local ts = require("nvim-treesitter")
ts.setup({
  -- optional: where to put installed parsers/queries
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- install parsers you want
ts.install({ "lua", "c", "rust" }, {sync = false})

