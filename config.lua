reload("lenn.options")
reload("lenn.keymaps")
reload("lenn.java")
reload("lenn.plugins.pomo")
reload("lenn.utils.templates")
reload("lenn.customTheme.lualine")
reload("lenn.core.which-keys")
reload("lenn.react")
reload("lenn.mariadb")
reload("lenn.avalonia")
-- reload("lenn.flutter")

-- vim.opt.termguicolors = true
lvim.colorscheme = "catppuccin-mocha"
lvim.transparent_window = true

lvim.builtin.nvimtree.setup.diagnostics.enable = false

-- //temporarles mientras encuentro un solucion
-- vim.treesitter.query.set("c_sharp", "locals", "")
-- vim.g.lvim_dap_enable = true
-- lvim.format_on_save.enabled = true
-- lvim.format_on_save.pattern = { "*.tsx", "html", "*.js", "*.ts", "*.jsx", "*.css", "*.scss", "*.json", "*.java", "*.lua" }

vim.opt.sidescrolloff = 8
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
vim.opt.clipboard = "unnamedplus"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.numberwidth = 2
vim.opt.shiftwidth = 2
lvim.builtin.gitsigns.active = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		vim.schedule(function()
			pcall(vim.treesitter.stop, args.buf)
		end)
	end,
})

vim.filetype.add({
	extension = {
		axaml = "xml",
	},
})

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

vim.keymap.set("n", "<leader>lg", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
		col = math.floor(vim.o.columns * 0.05),
		row = math.floor(vim.o.lines * 0.05),
		style = "minimal",
		border = "rounded",
	})
	vim.fn.termopen("lazygit", {
		on_exit = function()
			vim.api.nvim_win_close(win, true)
		end,
	})
	vim.cmd("startinsert")
end, { desc = "LazyGit" })

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

vim.diagnostic.config({
	update_in_insert = false,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	callback = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "rounded",
				width = math.floor(vim.o.columns * 0.9),
				height = math.floor(vim.o.lines * 0.9),
			},
			on_open = function()
				vim.cmd("startinsert!")
			end,
		})

		vim.keymap.set("n", "<leader>lg", function()
			lazygit:toggle()
		end, { desc = "LazyGit" })
	end,
})

--NOTE: CUSTOM PLUGINS -----------------------------------------------------------------
lvim.plugins = {
	-- flutter
	-- {
	--   'nvim-flutter/flutter-tools.nvim',
	--   lazy = false,
	--   dependencies = {
	--     'nvim-lua/plenary.nvim',
	--     'stevearc/dressing.nvim', -- optional for vim.ui.select
	--   },
	--   config = true,
	-- },
	--
	{
		"seblyng/roslyn.nvim",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {},
	},

	-- desactivar none-ls.nvim del core de LunarVim
	{ "nvimtools/none-ls.nvim", enabled = false },

	-- en tu spec de lazy.nvim
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- la reescrita, más alineada con la API nueva de 0.11/0.12
	},
	--posting
	{
		"james-t-larson/posting.nvim",
		config = function()
			require("posting").setup({
				keybinds = {
					{
						binding = "<leader>op",
						command = ":OpenPosting --collection posting-collection --env posting-envs/staging.env<CR>",
						desc = "Open Posting with dev env",
					},
				},
				ui = {
					border = "rounded", -- Border style for the Posting window
					width = 0.95, -- Width of the window relative to the editor
					height = 0.87, -- Height of the window relative to the editor
					x = 0.5, -- Horizontal center
					y = 0.5, -- Vertical center
				},
			})
		end,
	},
	-- --lazygit
	-- -- nvim v0.8.0
	-- "kdheepak/lazygit.nvim",
	-- lazy = true,
	-- cmd = {
	--   "LazyGit",
	--   "LazyGitConfig",
	--   "LazyGitCurrentFile",
	--   "LazyGitFilter",
	--   "LazyGitFilterCurrentFile",
	-- },
	-- -- optional for floating window border decoration
	-- dependencies = {
	--   "nvim-lua/plenary.nvim",
	-- },
	-- -- setting the keybinding for LazyGit with 'keys' is recommended in
	-- -- order to load the plugin when the command is run for the first time
	-- keys = {
	--   { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
	-- },
	-- brakets pair colored
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		config = function()
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
					vim = "rainbow-delimiters.strategy.local",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},

	-- html css

	{
		"Jezda1337/nvim-html-css",
		dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using nvim-cmp
		-- dependencies = { "saghen/blink.cmp", "nvim-treesitter/nvim-treesitter" }, -- Use this if you're using blink.cmp
		opts = {
			enable_on = { -- Example file types
				"html",
				"htmldjango",
				"tsx",
				"jsx",
				"erb",
				"svelte",
				"vue",
				"blade",
				"php",
				"templ",
				"astro",
			},
			handlers = {
				definition = {
					bind = "gd",
				},
				hover = {
					bind = "K",
					wrap = true,
					border = "none",
					position = "cursor",
				},
			},
			documentation = {
				auto_show = true,
			},
		},
	},
	-- autoregractos para archivos, mover directorios.
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	},

	-- imagen
	{
		"skardyy/neo-img",
		build = ":NeoImg Install",
		config = function()
			require("neo-img").setup()
		end,
	},

	-- -- dap
	{ "mfussenegger/nvim-jdtls" },

	-- mini indentline
	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 100,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = "▏", -- Personalizable
				options = {
					border = "none",
				},
			})
			vim.cmd([[highlight MiniIndentscopeSymbol guifg=#292c3c]])
		end,
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
		dependencies = "kevinhwang91/promise-async",
	},

	-- angular
	{ "nvim-treesitter/nvim-treesitter-angular" },

	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	--tailwind pick color
	{
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			document_color = {
				enabled = false,
			},
		},
	},

	-- {
	-- 	"laytan/tailwind-sorter.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
	-- 	build = "cd formatter && npm ci && npm run build",
	-- 	config = function()
	-- 		require("tailwind-sorter").setup({
	-- 			-- on_save_enabled = true,
	-- 			on_save_pattern = {
	-- 				"*.html",
	-- 				"*.js",
	-- 				"*.jsx",
	-- 				"*.tsx",
	-- 				"*.twig",
	-- 				"*.hbs",
	-- 				"*.php",
	-- 				"*.heex",
	-- 				"*.astro",
	-- 				"*.vue",
	-- 				"*.svelte",
	-- 			}, -- Patrones de archivos donde se activará
	-- 		})
	-- 	end,
	-- },
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	-- colores
	{
		"VidocqH/lsp-lens.nvim",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	--git
	{
		"sindrets/diffview.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
	},

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
		},
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
	{ "tpope/vim-fugitive" },
	-- neorg
	-- {
	--   "vhyrro/luarocks.nvim",
	--   priority = 999, -- Queremos que este plugin cargue primero
	--   config = true,  -- Esto ejecuta automáticamente `require("luarocks-nvim").setup()`
	-- },

	-- {
	--   "nvim-neorg/neorg",
	--   version = "*",                 -- Usa v9.x
	--   dependencies = {
	--     "vhyrro/luarocks.nvim",      -- aún requerido
	--     "nvim-neorg/lua-utils.nvim", -- nuevo requerido
	--     "pysan3/pathlib.nvim",       -- nuevo requerido
	--     "nvim-neotest/nvim-nio",     -- nuevo requerido
	--   },
	--   config = function()
	--     require("neorg").setup {
	--       load = {
	--         ["core.defaults"] = {},
	--         ["core.concealer"] = {},
	--         ["core.dirman"] = {
	--           config = {
	--             workspaces = {
	--               notes = "~/notes",
	--             },
	--           },
	--         },
	--       },
	--     }
	--   end,
	-- },

	{
		"nvim-neorg/neorg",
      version = "*",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"vhyrro/luarocks.nvim",
			"nvim-neorg/lua-utils.nvim",
			"pysan3/pathlib.nvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
					["core.ui.calendar"] = {},
				},
			})
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
		"brenoprata10/nvim-highlight-colors",
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
						accept = "<C-l>", -- Aceptar sugerencia
						next = "<M-]>", -- Siguiente sugerencia
						prev = "<M-[>", -- Sugerencia anterior
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
	--   dependencies = { "zbirenbaum/copilot.lua" },
	--   config = function()
	--     require("copilot_cmp").setup()
	--   end,
	-- },

	-- Copilot Chat Configuration
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "CopilotChat", "CopilotChatOpen" },
		build = "make tiktoken",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "github/copilot.vim" },
		},
		opts = {
			debug = false,
			window = {
				layout = "vertical",
				border = "rounded",
			},
		},
	},
	-- -- nextjs
	-- {
	--   "dreamsofcode-io/nvim-nextjs",
	-- },

	--auto tag
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["html"] = {
						enable_close = true,
					},
				},
			})
		end,
	},

	--rename files
	{
		"tpope/vim-eunuch",
		config = function()
			vim.cmd("cnoreabbrev rename Rename")
		end,
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
				flavour = "mocha",
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"shaunsingh/nord.nvim",
		name = "nord",
	},
	{
		"kyazdani42/blue-moon",
		name = "blue-moon",
	},
	{
		"olimorris/onedarkpro.nvim",
		-- priority = 1000, -- Ensure it loads first
		{
			"embark-theme/vim",
			name = "embark",
		},
		{
			"olivercederborg/poimandres.nvim",
			config = function()
				require("poimandres").setup({})
			end,
		},

		--react snippets
		{
			"mlaursen/vim-react-snippets",
			opts = {},
		},

		-- conform
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			opts = {
				formatters_by_ft = {
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					css = { "prettierd" },
					scss = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					lua = { "stylua" },
					java = { "google-java-format" },
					cs = { "csharpier" },
				},
				formatters = {
					["google-java-format"] = {
						command = "google-java-format",
						args = { "-" },
						stdin = true,
					},
				},
				format_on_save = {
					timeout_ms = 1000,
					lsp_fallback = true,
				},
			},
		},

		--error traslator
		{ "dmmulroy/ts-error-translator.nvim" },
		{
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					-- …
				})
			end,
		},

		-- go definition
		{
			"rmagatti/goto-preview",
			config = function()
				require("goto-preview").setup({
					width = 120, -- Width of the floating window
					height = 25, -- Height of the floating window
					default_mappings = false, -- Bind default mappings
					debug = false, -- Print debug information
					opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
					post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				})
			end,
		},
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
			"phaazon/hop.nvim",
			branch = "v2",
			event = "BufRead",
			config = function()
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		},
		-- numb line
		{
			"nacro90/numb.nvim",
			event = "BufRead",
			config = function()
				require("numb").setup({
					show_numbers = true, -- Enable 'number' for the window while peeking
					show_cursorline = true, -- Enable 'cursorline' for the window while peeking
				})
			end,
		},
		-- auto documentation

		{
			"danymat/neogen",
			version = "*",
			dependencies = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("neogen").setup({
					enabled = true,
					input_after_comment = true,
					jump_map = "<C-j>",
					languages = {
						typescript = {
							template = {
								annotation_convention = "tsdoc",
							},
						},
						typescriptreact = {
							template = {
								annotation_convention = "tsdoc",
							},
						},
						javascript = {
							template = {
								annotation_convention = "tsdoc",
							},
						},
						javascriptreact = {
							template = {
								annotation_convention = "tsdoc",
							},
						},
						java = {
							template = {
								annotation_convention = "javadoc",
							},
						},
					},
				})
			end,
		},

		-- mini  plugin complements
		{
			"echasnovski/mini.nvim",
			version = "*",
		},

		-- sql manager
		{
			"kristijanhusak/vim-dadbod-ui",
			dependencies = {
				{
					"tpope/vim-dadbod",
					lazy = true,
				},
				{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "sqlite" }, lazy = true },
			},
			cmd = {
				"DBUI",
				"DBUIToggle",
				"DBUIAddConnection",
				"DBUIFindBuffer",
			},
			init = function()
				vim.g.db_ui_use_nerd_fonts = 1
			end,
		},
		-- sqlite
		{ "kkharji/sqlite.lua" },

		-- headtailwind sort tailwind classes
		{
			"steelsojka/headwind.nvim",
		},
		-- scroll
		{
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({})
			end,
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
			opts = {},
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
			end,
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
			end,
		},
		{
			"edluffy/hologram.nvim",
		},
	},
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

--PERF: plugin requeridos
require("lsp-lens").setup({})

--NOTE: angular confi
require("lvim.lsp.manager").setup("angularls")

--NOTE: traductor de error config
require("ts-error-translator").setup()

lvim.lsp.on_attach_callback = function(client, bufnr)
	-- …
	require("lsp_signature").on_attach()
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

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })

vim.diagnostic.config({
	signs = true,
	underline = true,
	virtual_text = {
		prefix = " ",
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
})

lvim.builtin.cmp.formatting = {
	format = require("tailwindcss-colorizer-cmp").formatter,
}

-- vim.api.nvim_create_user_command("EnableRainbow", function()
--   require("lazy").load({ plugins = { "rainbow-delimiters.nvim" } })
--   vim.diagnostic.reset() -- opcional: refresca vista
-- end, {})

-- activar y desactivar rainbow delimiters
vim.api.nvim_create_user_command("EnableRainbow", function()
	require("lazy").load({ plugins = { "rainbow-delimiters.nvim" } })
	vim.defer_fn(function()
		vim.api.nvim_exec_autocmds("FileType", { buffer = 0 })
	end, 100)
end, {})

vim.api.nvim_create_user_command("DisableRainbow", function()
	-- Elimina los highlights aplicados
	vim.cmd([[
    highlight clear RainbowDelimiterRed
    highlight clear RainbowDelimiterYellow
    highlight clear RainbowDelimiterBlue
    highlight clear RainbowDelimiterOrange
    highlight clear RainbowDelimiterGreen
    highlight clear RainbowDelimiterViolet
    highlight clear RainbowDelimiterCyan
  ]])

	-- Fuerza redibujado
	vim.cmd("redraw")
end, {})

lvim.builtin.which_key.mappings["l"]["f"] = {
	function()
		require("conform").format({ async = true, lsp_fallback = true })
	end,
	"Format",
}
