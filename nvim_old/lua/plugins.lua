local plugins = {
  -- Core & UI
  {
    "folke/tokyonight.nvim",
    lazy = false,  -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "numToStr/Comment.nvim",     event = "VeryLazy" },
  { "xiyaowong/nvim-transparent" },
  { "akinsho/toggleterm.nvim" },
  { "HiPhish/rainbow-delimiters.nvim",
    --submodules = false,
  },
  { "akinsho/bufferline.nvim",        dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "moll/vim-bbye" },
  { "jesseduffield/lazygit",          cmd = "LazyGit" },
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
},
  { "slugbyte/unruly-worker" },
  { "nvim-telescope/telescope.nvim",  dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/playground" },
  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  -- Snippets
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  -- LSP & Tools
  { "jose-elias-alvarez/null-ls.nvim" },
  { "lewis6991/gitsigns.nvim" },
  {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false -- This plugin is already lazy
  }, 
  --{ "windwp/nvim-autopairs", event = "InsertEnter" },
{
    "mason-org/mason.nvim",
    opts = {}
},
{
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason-lspconfig").setup({
      -- 👇 this is the key
      automatic_enable = {
        exclude = { "rust_analyzer" },  -- let Rustaceanvim handle Rust
      },
      automatic_installation = true,
    })
  end,
}

,

  -- Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
}

-- Automatically add all plugins from plugin_configs/*.lua
local plugin_configs_path = vim.fn.stdpath("config") .. "/lua/plugin_configs"
for _, file in ipairs(vim.fn.readdir(plugin_configs_path)) do
  if file:match("%.lua$") then
    local plugin = require("plugin_configs." .. file:gsub("%.lua$", ""))
    table.insert(plugins, plugin)
  end
end


return plugins
