
vim.pack.add({
  { src = "https://github.com/williamboman/mason.nvim", name = "mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
})
vim.cmd.packadd("mason.nvim")
vim.cmd.packadd("mason-lspconfig.nvim")
vim.cmd.packadd("nvim-lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd" },
})
vim.lsp.config("lua_ls",{
  settings = {
    Lua = {
  runtime = {version = "LuaJIT"},
  diagnostics = {
    --removes 'undefine global vim' warning 
    globals = {"vim"}
  }
}}
})
-- Telescope-powered definition picker with preview
local function lsp_keymaps(bufnr)
  local builtin = require("telescope.builtin")
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gd", function()
    builtin.lsp_definitions({
      previewer = true,
      layout_strategy = "horizontal",
      layout_config = { preview_width = 0.60 },
    })
  end, vim.tbl_extend("force", opts, { desc = "Goto definition (Telescope)" }))

  vim.keymap.set("n", "gr", function()
    builtin.lsp_references({ previewer = true })
  end, vim.tbl_extend("force", opts, { desc = "References (Telescope)" }))

  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
end

-- Attach keymaps when an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    lsp_keymaps(ev.buf)
  end,
})

vim.filetype.add({
  extension = {h = "c"},
})
