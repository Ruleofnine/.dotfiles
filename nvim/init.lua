local profile = require("core.profile")

require("core.opts")
require("core.health")
require("plugins.nvim-treesitter")
require("plugins.tokyonight")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.custerm")
require("plugins.lsp")
require("plugins.oil")
require("plugins.writing")
require("plugins.compile-mode")
require("core.keymaps")
require("core.rulelib").setup()
require("core.diagnostics")
require("mini.icons").setup()
require("core.format")
-- Desktop/development-machine plugins
if profile.is_desktop() then
	vim.pack.add({
		"https://github.com/mfussenegger/nvim-jdtls",
		"https://github.com/dmtrKovalenko/fff.nvim",
	})
end
