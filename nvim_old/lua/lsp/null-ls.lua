local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- JS / TS / JSON
    formatting.prettier.with({
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      filetypes = { "javascript", "typescript", "typescriptreact", "json" },
    }),

    -- Python
    formatting.black.with({
      extra_args = { "--fast" },
      filetypes = { "python" },
    }),
    diagnostics.flake8.with({
      filetypes = { "python" },
    }),

    -- Lua
    formatting.stylua.with({
      filetypes = { "lua" },
    }),

    -- Git actions
    null_ls.builtins.code_actions.gitsigns,
  },
})

