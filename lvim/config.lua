-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- NOTE: Ganeral Setting
lvim.colorscheme = "catppuccin"
lvim.format_on_save.pattern = { "*.lua", "*.js", "*.jsx", "*ts", "*tsx", ".json", "*.cs", "*.prisma" }
lvim.format_on_save.enabled = true
lvim.transparent_window = true
vim.opt.wrap = false
vim.opt.relativenumber = true
lvim.debug = false


local opts = {


}
require("lvim.lsp.manager").setup("tailwindcss", opts)
require("lvim.lsp.manager").setup("eslint", opts)
require("lvim.lsp.manager").setup("cssls", {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  },
})


-- NOTE: Lualine Setting
lvim.builtin.lualine.active = false
lvim.builtin.lualine.style = "lvim"


-- NOTE:  Nvimtree Setting
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_closed = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_open = ""
lvim.builtin.nvimtree.setup.filesystem_watchers.enable = false

-- NOTE:  Enable To Use Nvimtree Float Style
local HEIGHT_RATIO = .7
local WIDTH_RATIO = .7
local screen_w = vim.opt.columns:get()
local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
local window_w = screen_w * WIDTH_RATIO
local window_h = screen_h * HEIGHT_RATIO
local window_w_int = math.floor(window_w)
local window_h_int = math.floor(window_h)
local center_x = (screen_w - window_w) / 2
local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_netrw = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.sync_root_with_cwd = true
lvim.builtin.nvimtree.setup.view.float.enable = true
lvim.builtin.nvimtree.setup.view.float.open_win_config.border = "rounded"
lvim.builtin.nvimtree.setup.view.float.open_win_config.relative = "editor"
lvim.builtin.nvimtree.setup.view.float.open_win_config.row = center_y
lvim.builtin.nvimtree.setup.view.float.open_win_config.col = center_x
lvim.builtin.nvimtree.setup.view.float.open_win_config.width = window_w_int
lvim.builtin.nvimtree.setup.view.float.open_win_config.height = window_h_int
lvim.builtin.nvimtree.setup.view.width = math.floor(vim.opt.columns:get() * WIDTH_RATIO)


-- NOTE: Telescope Mapping
lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  g = { "<cmd>Telescope git_files<cr>", "Find git files" },
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  f = { "<cmd>Telescope find_files<cr>", "Find files" },
  t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  T = { "<cmd>TodoTelescope<cr>", "Find TODO" },
  s = { "<cmd>Telescope grep_string<cr>", "Find String" },
  h = { "<cmd>Telescope help_tags<cr>", "Help" },
  H = { "<cmd>Telescope highlights<cr>", "Highlights" },
  i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
  l = { "<cmd>Telescope resume<cr>", "Last Search" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
  R = { "<cmd>Telescope registers<cr>", "Registers" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  C = { "<cmd>Telescope commands<cr>", "Commands" },
}

-- NOTE: Telescope Config
lvim.builtin.telescope.theme = "center"


-- NOTE: Telescope Extention
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "file_browser")
end


-- NOTE: Tmux Mapping
lvim.keys.normal_mode["<C-h>"] = "<cmd> TmuxNavigateLeft<CR>"
lvim.keys.normal_mode["<C-l>"] = "<cmd> TmuxNavigateRight<CR>"
lvim.keys.normal_mode["<C-j>"] = "<cmd> TmuxNavigateDown<CR>"
lvim.keys.normal_mode["<C-k>"] = "<cmd> TmuxNavigateUp<CR>"


-- NOTE: Additional Plugins
lvim.plugins = {
  -- NOTE: Catppuccin Theme
  { "catppuccin/nvim",   name = "catppuccin", priority = 1000 },


  -- NOTE: Auto Save
  -- {
  --   "Pocco81/auto-save.nvim",
  --   config = function()
  --     require("auto-save").setup()
  --   end,
  -- },
  --
  -- NOTE: Auto Close Tag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- NOTE: Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
    end,
  },

  -- NOTE: Todo Comment
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- NOTE: Tmux
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- NOTE: Noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = { inc_rename = true }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- NOTE: Notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1000,
      background_colour = "#000000",
      render = "minimal",


    },
  },

  -- NOTE: HTML Server
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    build = "npm install --prefix server",
  },

  {
    "nvim-telescope/telescope-fzy-native.nvim",
    build = "make",
    event = "BufRead",
  },

  { "github/copilot.vim" },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  -- {
  --   'b0o/incline.nvim',
  --   config = function()
  --     require('incline').setup()
  --   end,
  --   -- Optional: Lazy load Incline
  --   event = 'VeryLazy',
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function()
  --     require("neo-tree").setup({
  --       close_if_last_window = true,
  --       window = {
  --         width = 30,
  --       },
  --       buffers = {
  --         follow_current_file = true,
  --       },
  --       filesystem = {
  --         follow_current_file = true,
  --         filtered_items = {
  --           hide_dotfiles = false,
  --           hide_gitignored = false,
  --           hide_by_name = {
  --             "node_modules"
  --           },
  --           never_show = {
  --             ".DS_Store",
  --             "thumbs.db"
  --           },
  --         },
  --       },
  --     })
  --   end
  -- },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json", },
  },
  {
    name = "csharpier",
    filetypes = { "cs" },
  }

}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },

}


local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}

-- NOTE: Copilot
-- table.insert(lvim.plugins, { "github/copilot.vim" },)

-- NOTE: Inc Rename
table.insert(lvim.plugins, {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end,
      desc = "Incremental rename",
      mode = "n",
      noremap = true,
      expr = true,
    },
  },
  config = true,
})
