vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core config
require("options")
require("autocmds")
require("lsp.null-ls")

-- ✨ Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(require("plugins"))
vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = { enable = true },
        },
        check = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        checkOnSave = true,

        diagnostics = {
          enable = true,  -- ✅ Correct key name
          experimental = { enable = true },
          disabled = {
            "unresolved-proc-macro", -- optional
            "inactive-code",         -- optional
          },
        },
      },
    },
  },
}

-- Rust formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})
local harpoon = require('harpoon')
harpoon:setup({})
require("keymaps")

