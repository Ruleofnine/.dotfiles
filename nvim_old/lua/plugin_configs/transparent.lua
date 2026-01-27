return {
	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		config = function()
require("transparent").setup({
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups
    "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
    "all",
    "NeoTreeNormal",
    'NeoTreeNormalNC',
    'NeoTreePopup',
    'NeoTreeSymlink',
    'ToggleTerm1Normal',
    'ToggleTerm1NormalFloat',
    'ToggleTerm1FloatBorder',
    'ToggleTerm1SignColumn',
    'ToggleTerm1EndOfBuffer',
    'ToggleTerm1WinBar',
    'ToggleTerm1WinBarNC',
    'ToggleTerm1StatusLine',
    'ToggleTerm1StatusLineNC',
    'LspFloatWinNormal',
    'LspFloatWinBorder',
    'LspReferenceText',
    'LspSagaHoverBorder',
    'LspDefPreviewBorder',
    'LspCodeActionContent',
    'PmenuSbar',
    'NormalFloat',
    'FloatBorder',
    'LspCodeLens',
    'NvimTreeNormalNC',
    'NvimTreePopup',
    'TelescopeNormal',
    'TelescopeBorder',
    'TelescopePromptNormal',
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})
		end,
	}
}
