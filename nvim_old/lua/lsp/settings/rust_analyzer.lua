return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        buildScripts = { enable = false },
        runBuildScripts = false,
        autoreload = false, -- Disable autoreload for better perf
      },
      checkOnSave = true, -- ✅ must be boolean
      check = {           -- ✅ if you want clippy
        command = "clippy",
      },
      completion = {
        addCallArgumentSnippets = false,
        addCallParenthesis = false,
      },
      diagnostics = {
        enable = false, -- Disable diagnostics while typing
      },
      inlayHints = { enable = false },
      lens = { enable = false },
      procMacro = { enable = false },
      files = { watcher = "client" },
      typing = { autoClosingAngleBrackets = false },
    },
  },
}

