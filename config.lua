reload("lenn.options")
reload("lenn.keymaps")
reload("lenn.java")
reload("lenn.plugins.pomo")
reload("lenn.utils.templates")
reload("lenn.customTheme.lualine")
reload("lenn.core.which-keys")
reload("lenn.react")
reload("lenn.mariadb")


-- vim.opt.termguicolors = true
lvim.colorscheme = "catppuccin-macchiato"
lvim.transparent_window = true
-- lvim.format_on_save = true
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation

vim.g.lvim_dap_enable = true


vim.opt.sidescrolloff = 8
vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
vim.opt.clipboard = "unnamedplus"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.numberwidth = 2
lvim.builtin.gitsigns.active = true


-- vim.opt.spell = true
-- vim.opt.spellang = "en_us, es"
-- vim.opt.scrolloff = 2


lvim.builtin.indentlines.active = false



-- NOTE: for windows only
-- Enable powershell as your default shell
-- vim.opt.shell = "pwsh.exe"
-- vim.opt.shellcmdflag =
-- "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
-- vim.cmd [[
-- 		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
-- 		set shellquote= shellxquote=
--   ]]

-- Set a compatible clipboard manager in windows
-- vim.g.clipboard = {
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --lf",
--     ["*"] = "win32yank.exe -o --lf",
--   },
-- }
--
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },

  paste = {
    ["+"] = "wl-paste",
    ["*"] = "wl-paste",
  },

  cache_enabled = 0,
}

--NOTE: CUSTOM PLUGINS -----------------------------------------------------------------
lvim.plugins = {

  -- imagen
  {
    'skardyy/neo-img',
    build = ":NeoImg Install",
    config = function()
      require('neo-img').setup()
    end
  },
  { "nvimtools/none-ls.nvim" },

  -- -- dap
  { "mfussenegger/nvim-jdtls" },

  -- mini indentline
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup {
        draw = {
          delay = 100,
          animation = require("mini.indentscope").gen_animation.none()
        },
        symbol = "▏", -- Personalizable
        options = {
          border = "none"
        }
      }
      vim.cmd [[highlight MiniIndentscopeSymbol guifg=#292c3c]]
    end
  },
  -- image view
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },

  --auto-save
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave" },
    opts = {
      immediate_save = false,
      defer_save = true,
      cancel_deferred_save = true,
      write_all_buffers = false,
      noautocmd = false,
      lockmarks = false,
      debounce_delay = 35000,
      debug = false,
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async"
  },

  -- angular
  { "nvim-treesitter/nvim-treesitter-angular" },

  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  },
  --tailwind pick color
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}
  },
  {
    'VidocqH/lsp-lens.nvim'
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  --git
  {
    "sindrets/diffview.nvim"
  },
  {
    "lewis6991/gitsigns.nvim"
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",

      "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    config = true
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true
  },
  { "tpope/vim-fugitive" },
  -- neorg
  {
    "vhyrro/luarocks.nvim",
    priority = 999, -- Queremos que este plugin cargue primero
    config = true,  -- Esto ejecuta automáticamente `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "vhyrro/luarocks.nvim" },
    -- version = "*",
    version = "v7.0.0",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Carga comportamiento predeterminado
          ["core.concealer"] = {}, -- Añade íconos bonitos a tus documentos
          ["core.dirman"] = {      -- Gestiona espacios de trabajo de Neorg
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },

  --markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "brenoprata10/nvim-highlight-colors"
  },

  -- refactor
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  -- Copilot Core Configuration
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",  -- Aceptar sugerencia
            next = "<M-]>",    -- Siguiente sugerencia
            prev = "<M-[>",    -- Sugerencia anterior
            dismiss = "<C-]>", -- Descartar sugerencia
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            open = "<C-CR>",
          },
        },
        filetypes = {
          markdown = true,
          help = true,
          ["*"] = true,
        },
      })
    end,
  },

  --ccpmm
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = { "zbirenbaum/copilot.lua" }, -- Dependencia de copilot.lua
  --   config = function()
  --     require("copilot_cmp").setup()             -- Configura la integración con nvim-cmp
  --   end,
  -- },

  -- Copilot Chat Configuration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = { "CopilotChat", "CopilotChatOpen" }, -- Comandos para abrir el chat de Copilot
    build = "make tiktoken",                    -- Comando de construcción
    dependencies = {
      { "nvim-lua/plenary.nvim" },              -- Dependencia para funciones Lua comunes
      { "github/copilot.vim" },                 -- Dependencia de Copilot para Vim
    },
    opts = {
      debug = false,
      window = {
        layout = "float",   -- Layout flotante para el chat
        border = "rounded", -- Borde redondeado para la ventana
      },
    },
  },
  -- nextjs
  {
    "dreamsofcode-io/nvim-nextjs",
  },

  --auto tag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false
        },
        per_filetype = {
          ["html"] = {
            enable_close = true,
          }
        }
      })
    end
  },

  -- notificacion
  {
    "vigoux/notifier.nvim",
    config = function()
      require 'notifier'.setup {
        -- You configuration here
      }
    end
  },

  --rename files
  {
    'tpope/vim-eunuch',
    config = function()
      vim.cmd('cnoreabbrev rename Rename')
    end
  },

  --rename words
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },

  -- themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- puedes cambiarlo a "latte", "frappe",entre otras disponibles ;)
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine"
  },
  {
    'shaunsingh/nord.nvim',
    name = "nord"
  },
  {
    "kyazdani42/blue-moon",
    name = "blue-moon"
  },
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000, -- Ensure it loads first
    {
      'embark-theme/vim',
      name = 'embark'
    },
    {
      'olivercederborg/poimandres.nvim',
      config = function()
        require('poimandres').setup {
        }
      end,
    },

    -- react
    {
      "mlaursen/vim-react-snippets",
      config = function()
        require("vim-react-snippets").lazy_load()
      end,
    },

    -- conform code cleaner
    {
      'stevearc/conform.nvim',
      opts = {},
    },
    --error traslator
    { 'dmmulroy/ts-error-translator.nvim' },
    {
      "ray-x/lsp_signature.nvim",
      config = function()
        require "lsp_signature".setup({
          -- …
        })
      end,
    },

    -- go definition
    {
      "rmagatti/goto-preview",
      config = function()
        require('goto-preview').setup {
          width = 120,              -- Width of the floating window
          height = 25,              -- Height of the floating window
          default_mappings = false, -- Bind default mappings
          debug = false,            -- Print debug information
          opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
          post_open_hook = nil      -- A function taking two arguments, a buffer and a window to be ran as a hook.
        }
      end
    },
    --
    -- codium ia autocompletion
    {
      "monkoose/neocodeium",
      -- event = "VeryLazy",
      keys = { "<A-6>" },
      config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup()
        vim.keymap.set("i", "<A-f>", neocodeium.accept)
      end,
    },
    --avante
    -- {
    --   "yetone/avante.nvim",
    --   event = "VeryLazy",
    --   version = false, -- Never set this value to "*"! Never!
    --   opts = {
    --     -- add any opts here
    --     -- for example
    --     provider = "openai",
    --     openai = {
    --       endpoint = "https://api.openai.com/v1",
    --       model = "gpt-4o",         -- your desired model (or use gpt-4o, etc.)
    --       timeout = 30000,          -- Timeout in milliseconds, increase this for reasoning models
    --       temperature = 0,
    --       max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --       --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    --     },
    --   },
    --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --   build = "make",
    --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    --   dependencies = {
    --     "nvim-treesitter/nvim-treesitter",
    --     "stevearc/dressing.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "MunifTanjim/nui.nvim",
    --     --- The below dependencies are optional,
    --     "echasnovski/mini.pick",     -- for file_selector provider mini.pick
    --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --     "hrsh7th/nvim-cmp",          -- autocompletion for avante commands and mentions
    --     "ibhagwan/fzf-lua",          -- for file_selector provider fzf
    --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --     "zbirenbaum/copilot.lua",    -- for providers='copilot'
    --     {
    --       -- support for image pasting
    --       "HakonHarnes/img-clip.nvim",
    --       event = "VeryLazy",
    --       opts = {
    --         -- recommended settings
    --         default = {
    --           embed_image_as_base64 = false,
    --           prompt_for_file_name = false,
    --           drag_and_drop = {
    --             insert_mode = true,
    --           },
    --           -- required for Windows users
    --           use_absolute_path = true,
    --         },
    --       },
    --     },
    --     {
    --       -- Make sure to set this up properly if you have lazy=true
    --       'MeanderingProgrammer/render-markdown.nvim',
    --       opts = {
    --         file_types = { "markdown", "Avante" },
    --       },
    --       ft = { "markdown", "Avante" },
    --     },
    --   },
    -- },
    -- move motions hop
    {
      'phaazon/hop.nvim',
      branch = 'v2',
      event = "BufRead",
      config = function()
        require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    },
    -- numb line
    {
      "nacro90/numb.nvim",
      event = "BufRead",
      config = function()
        require("numb").setup {
          show_numbers = true,    -- Enable 'number' for the window while peeking
          show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        }
      end,
    },
    -- auto documentation
    {
      "danymat/neogen",
      config = true,
      -- Uncomment next line if you want to follow only stable versions
      version = "*"
    },
    -- mini  plugin complements
    {
      'echasnovski/mini.nvim',
      version = '*'
    },

    -- sql manager
    {
      'kristijanhusak/vim-dadbod-ui',
      dependencies = {
        {
          'tpope/vim-dadbod',
          lazy = true
        },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql', 'sqlite' }, lazy = true },
      },
      cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
      },
      init = function()
        vim.g.db_ui_use_nerd_fonts = 1
      end,
    },
    -- sqlite
    { "kkharji/sqlite.lua" },

    -- headtailwind sort tailwind classes
    {
      "steelsojka/headwind.nvim"
    },
    -- scroll
    {
      "karb94/neoscroll.nvim",
      config = function()
        require('neoscroll').setup({})
      end
    },
    -- diagnostics viewer
    {
      "folke/trouble.nvim",
      opts = {},
      cmd = "Trouble",
    },
    -- multi cursort
    -- {
    --   "brenton-leighton/multiple-cursors.nvim",
    --   version = "*", -- Use the latest tagged version
    --   opts = {},     -- This causes the plugin setup function to be called
    --   keys = {
    --     { "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "x" },      desc = "Add cursor and move down" },
    --     { "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "x" },      desc = "Add cursor and move up" },

    --     { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
    --     { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

    --     { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" },      desc = "Add or remove cursor" },

    --     { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" },      desc = "Add cursors to cword" },
    --     { "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" },      desc = "Add cursors to cword in previous area" },

    --     { "<Leader>d",     "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" },      desc = "Add cursor and jump to next cword" },
    --     { "<Leader>D",     "<Cmd>MultipleCursorsJumpNextMatch<CR>",    mode = { "n", "x" },      desc = "Jump to next cword" },

    --     { "<Leader>l",     "<Cmd>MultipleCursorsLock<CR>",             mode = { "n", "x" },      desc = "Lock virtual cursors" },
    --   },
    -- },
    -- focus ligth
    {
      "folke/twilight.nvim",
      opts = {
      }
    },
    -- create folder advance
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
    -- for winddows
    -- {
    --   "lervag/vimtex",
    --   lazy = false, -- we don't want to lazy load VimTeX
    --   -- tag = "v2.15", -- uncomment to pin to a specific release
    --   init = function()
    --     -- -- Configuración para usar SumatraPDF solo en windows
    --     -- vim.g.vimtex_view_method = "general"
    --     -- vim.g.vimtex_view_general_viewer = "C:\\Users\\user\\AppData\\Local\\SumatraPDF\\SumatraPDF.exe"
    --     -- vim.g.vimtex_view_general_options = "-reuse-instance"

    --     -- Configurar compilador para latexmk
    --     vim.g.vimtex_compiler_method = "latexmk"
    --     vim.g.vimtex_compiler_latexmk = {
    --       build_dir = "build", -- Cambia si usas un directorio diferente
    --       options = {
    --         "-pdf",
    --         "-shell-escape",
    --         "-verbose",
    --         "-file-line-error",
    --         "-synctex=1",
    --         "-interaction=nonstopmode",
    --       },
    --     }
    --   end
    -- },
    -- d
    -- latex
    {
      "lervag/vimtex",
      lazy = false,
      init = function()
        -- Configuración para usar Okular
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_general_viewer = "/var/lib/snapd/snap/bin/okular"
        vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

        -- Configurar compilador para latexmk
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
          build_dir = "build", -- Cambia si usas un directorio diferente
          options = {
            "-shell-escape",
            "-verbose",
            "-file-line-error",
            "-synctex=1",
            "-interaction=nonstopmode",
          },
        }
      end
    },
    -- zotero
    {
      "jalvesaq/zotcite",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("zotcite").setup({
          -- your options here (see doc/zotcite.txt)
        })
      end
    },
    {
      "edluffy/hologram.nvim"
    }
  }
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

--PERF: plugin requeridos
require 'lsp-lens'.setup({})

--NOTE: angular confi
require("lvim.lsp.manager").setup("angularls")

--NOTE: traductor de error config
require("ts-error-translator").setup()

lvim.lsp.on_attach_callback = function(client, bufnr)
  -- …
  require "lsp_signature".on_attach()
  -- …
end


vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.tsx",
  callback = function()
    local ok, gs = pcall(require, "gitsigns")
    if ok and not vim.b.gitsigns_attached then
      gs.attach()
    end
  end,
})


lvim.keys.normal_mode["<leader>tt"] = function()
  vim.diagnostic.open_float({ border = "rounded", scope = "line" })
end

lvim.lsp.installer.automatic_installation = true


vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })


vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = {
    prefix = " ", -- opcional: ícono en texto virtual también
  },
})
