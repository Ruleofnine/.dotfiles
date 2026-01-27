return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- prevent 'vim' undefined warning
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

