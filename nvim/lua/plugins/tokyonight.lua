vim.pack.add({"https://github.com/folke/tokyonight.nvim"})
require("tokyonight").setup({
  transparent = true,
})
vim.cmd.colorscheme("tokyonight-moon")

local function set_float_bg(bg)
  local hl = vim.api.nvim_set_hl

  -- Core float groups
  hl(0, "NormalFloat", { bg = bg })
  hl(0, "FloatBorder", { bg = bg })
  hl(0, "FloatTitle",  { bg = bg })

  -- Telescope-specific groups (covers prompt/results/preview)
  hl(0, "TelescopeNormal",       { bg = "none" })
  hl(0, "TelescopeBorder",       { bg = bg })
  hl(0, "TelescopePromptNormal", { bg = bg })
  hl(0, "TelescopePromptBorder", { bg = bg })
  hl(0, "TelescopeResultsNormal",{ bg = bg })
  hl(0, "TelescopeResultsBorder",{ bg = bg })
  hl(0, "TelescopePreviewNormal",{ bg = bg })
  hl(0, "TelescopePreviewBorder",{ bg = bg })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local foot_bg = "#0b1020" -- <-- set this to your foot background
    set_float_bg(foot_bg)
  end,
})

-- If you already set your colorscheme earlier in init.lua, you can also call it once:
set_float_bg("#0b1020")
