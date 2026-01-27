return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        size = 20,
        open_mapping = [[<c-t>]],
        hide_numbers = false,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        dir = "cwd",
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
        },
        highlights = {
          Normal = { guibg = "NONE", guifg = "NONE" },
          NormalFloat = { link = "Normal" },
          FloatBorder = { guifg = "NONE", guibg = "NONE" },
          horizontal = { guifg = "NONE", guibg = "NONE" },
        },
      })

      -- Terminal keymaps
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-y>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-n>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-e>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-o>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      -- Custom terminals
      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new({ cmd = "node", hidden = true })
      function _NODE_TOGGLE()
        node:toggle()
      end

      local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
      function _NCDU_TOGGLE()
        ncdu:toggle()
      end

      local htop = Terminal:new({ cmd = "htop", hidden = true })
      function _HTOP_TOGGLE()
        htop:toggle()
      end

      local python = Terminal:new({ cmd = "python", hidden = true })
      function _PYTHON_TOGGLE()
        python:toggle()
      end
    end,
  },
}

