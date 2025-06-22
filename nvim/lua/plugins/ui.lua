return {
  {
    -- "nvim-lualine/lualine.nvim",
    -- config = function()
    --   local colors = {
    --     blue = "#80a0ff",
    --     cyan = "#79dac8",
    --     black = "#080808",
    --     white = "#c6c6c6",
    --     red = "#ff5189",
    --     violet = "#d183e8",
    --     grey = "#303030",
    --   }
    --
    --   local bubbles_theme = {
    --     normal = {
    --       a = { fg = colors.black, bg = colors.violet },
    --       b = { fg = colors.white, bg = colors.grey },
    --       c = { fg = colors.white },
    --     },
    --
    --     insert = { a = { fg = colors.black, bg = colors.blue } },
    --     visual = { a = { fg = colors.black, bg = colors.cyan } },
    --     replace = { a = { fg = colors.black, bg = colors.red } },
    --
    --     inactive = {
    --       a = { fg = colors.white, bg = colors.black },
    --       b = { fg = colors.white, bg = colors.black },
    --       c = { fg = colors.white },
    --     },
    --   }
    --   return {
    --     require("lualine").setup({
    --       options = {
    --         theme = "catppuccin",
    --         component_separators = "",
    --         section_separators = { left = "", right = "" },
    --       },
    --       sections = {
    --         lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    --         lualine_b = { "filename", "branch" },
    --         lualine_c = {
    --           "%=", --[[ add your center compoentnts here in place of this comment ]]
    --         },
    --         lualine_x = {},
    --         lualine_y = { "filetype", "progress" },
    --         lualine_z = {
    --           { "location", separator = { right = "" }, left_padding = 2 },
    --         },
    --       },
    --       inactive_sections = {
    --         lualine_a = { "filename" },
    --         lualine_b = {},
    --         lualine_c = {},
    --         lualine_x = {},
    --         lualine_y = {},
    --         lualine_z = { "location" },
    --       },
    --       tabline = {},
    --       extensions = {},
    --     }),
    --   }
    -- end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil, -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 0, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "float",
          popup = {
            border = "rounded",
            size = { height = 0.7, width = 0.7 },
            position = "50%",
          },
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            -- Read `# Preview Mode` for more information
            ["l"] = "focus_preview",
            -- ["S"] = "open_split",
            -- ["s"] = "open_vsplit",
            -- ["s"] = "system_open",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
              "node_modules",
              "package-lock.json",
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            always_show_by_pattern = { -- uses glob style patterns
              --".env*",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
              "thumbs.db",
              ".git",
              ".next",
              "node_modules",
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
              ["s"] = "system_open",

              -- ['<key>'] = function(state) ... end,
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
              -- ['<key>'] = function(state, scroll_padding) ... end,
            },
          },

          commands = {
            system_open = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              -- macOs: open file in default application in the background.
              vim.fn.jobstart({ "open", "-g", path }, { detach = true })
              -- Linux: open file in default application
              -- vim.fn.jobstart({ "xdg-open", path }, { detach = true })

              -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
              local p
              local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
              if lastSlashIndex then
                p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
              else
                p = path -- If no slash found, return original path
              end
              vim.cmd("silent !start explorer " .. p)
            end,
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end,
  },
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      {
        cmdline = {
          enabled = true, -- enables the Noice cmdline UI
          view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
          opts = {}, -- global options for the cmdline. See section on views
          ---@type table<string, CmdlineFormat>
          format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
          },
        },
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          view = "notify", -- default view for messages
          view_error = "notify", -- view for errors
          view_warn = "notify", -- view for warnings
          view_history = "messages", -- view for :messages
          view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
          enabled = true, -- enables the Noice popupmenu UI
          ---@type 'nui'|'cmp'
          backend = "nui", -- backend to use to show regular cmdline completions
          ---@type NoicePopupmenuItemKind|false
          -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
          kind_icons = {}, -- set to `false` to disable icons
        },
        -- default options for require('noice').redirect
        -- see the section on Command Redirection
        ---@type NoiceRouteConfig
        redirect = {
          view = "popup",
          filter = { event = "msg_show" },
        },
        -- You can add any custom commands below that will be available with `:Noice command`
        ---@type table<string, NoiceCommand>
        commands = {
          history = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {
              any = {
                { event = "notify" },
                { error = true },
                { warning = true },
                { event = "msg_show", kind = { "" } },
                { event = "lsp", kind = "message" },
              },
            },
          },
          -- :Noice last
          last = {
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = {
              any = {
                { event = "notify" },
                { error = true },
                { warning = true },
                { event = "msg_show", kind = { "" } },
                { event = "lsp", kind = "message" },
              },
            },
            filter_opts = { count = 1 },
          },
          -- :Noice errors
          errors = {
            -- options for the message history that you get with `:Noice`
            view = "popup",
            opts = { enter = true, format = "details" },
            filter = { error = true },
            filter_opts = { reverse = true },
          },
          all = {
            -- options for the message history that you get with `:Noice`
            view = "split",
            opts = { enter = true, format = "details" },
            filter = {},
          },
        },
        notify = {
          -- Noice can be used as `vim.notify` so you can route any notification like other messages
          -- Notification messages have their level and other properties set.
          -- event is always "notify" and kind can be any log level as a string
          -- The default routes will forward notifications to nvim-notify
          -- Benefit of using Noice for this is the routing and consistent history view
          enabled = true,
          view = "notify",
        },
        lsp = {
          progress = {
            enabled = true,
            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            --- @type NoiceFormat|string
            format = "lsp_progress",
            --- @type NoiceFormat|string
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
          },
          override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = false,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = false,
          },
          hover = {
            enabled = true,
            silent = false, -- set to true to not show a message if hover is not available
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {}, -- merged with defaults from documentation
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {}, -- merged with defaults from documentation
          },
          message = {
            -- Messages shown by lsp servers
            enabled = true,
            view = "notify",
            opts = {},
          },
          -- defaults for hover and signature help
          documentation = {
            view = "hover",
            ---@type NoiceViewOptions
            opts = {
              lang = "markdown",
              replace = true,
              render = "plain",
              format = { "{message}" },
              win_options = { concealcursor = "n", conceallevel = 3 },
            },
          },
        },
        markdown = {
          hover = {
            ["|(%S-)|"] = vim.cmd.help, -- vim help links
            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
          },
          highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
          },
        },
        health = {
          checker = true, -- Disable if you don't want health checks to run
        },
        ---@type NoicePresets
        presets = {
          -- you can enable a preset by setting it to true, or a table that will override the preset config
          -- you can also add custom presets that you can enable/disable with enabled=true
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
        ---@type NoiceConfigViews
        views = {}, ---@see section on views
        ---@type NoiceRouteConfig[]
        routes = {}, --- @see section on routes
        ---@type table<string, NoiceFilter>
        status = {}, --- @see section on statusline components
        ---@type NoiceFormatOptions
        format = {}, --- @see section on formatting
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[

████████╗██╗  ██╗███████╗███████╗ ██████╗ ██████╗ ███████╗██████╗ ███████╗
╚══██╔══╝██║  ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗╚══███╔╝
   ██║   ███████║█████╗  █████╗  ██║   ██║██████╔╝█████╗  ██║  ██║  ███╔╝ 
   ██║   ██╔══██║██╔══╝  ██╔══╝  ██║   ██║██╔══██╗██╔══╝  ██║  ██║ ███╔╝  
   ██║   ██║  ██║███████╗██║     ╚██████╔╝██║  ██║███████╗██████╔╝███████╗
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝

                                                                  @thefordz
      ]]

      logo = string.rep("\n", 5) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = "󰦛 ", key = "s" },
            { action = 'Telescope find_files hidden=true theme=dropdown',          desc = " Find file",       icon = " ", key = "f" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
