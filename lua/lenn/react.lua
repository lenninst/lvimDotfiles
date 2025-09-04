-- -- Evitar que LunarVim omita tsserver
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
--   function(server) return server ~= "tsserver" end,
--   lvim.lsp.automatic_configuration.skipped_servers
-- )

-- -- tsserver con navic
-- local navic = require("nvim-navic")
-- require("lvim.lsp.manager").setup("tsserver", {
--   filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
--   on_attach = function(client, bufnr)
--     if client.server_capabilities.documentSymbolProvider then
--       navic.attach(client, bufnr)
--     end
--   end,
--   init_options = { hostInfo = "neovim" },
-- })

-- -- none-ls para prettier y eslint_d
-- local none_ls = require("none-ls")
-- none_ls.setup({
--   sources = {
--     none_ls.builtins.formatting.prettier.with({
--       filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "html", "css", "markdown" },
--     }),
--     none_ls.builtins.diagnostics.eslint_d.with({
--       condition = function(utils)
--         return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js" })
--       end,
--     }),
--     none_ls.builtins.code_actions.eslint_d,
--   },
-- })

-- -- LSP TailwindCSS
-- require("lvim.lsp.manager").setup("tailwindcss", {
--   filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
--   init_options = {
--     userLanguages = {
--       javascript = "javascript",
--       javascriptreact = "javascriptreact",
--       typescript = "typescript",
--       typescriptreact = "typescriptreact",
--     }
--   },
-- })

-- -- Completado con íconos y soporte para tailwind-tools
-- lvim.builtin.cmp.formatting = {
--   format = require("lspkind").cmp_format({
--     before = require("tailwind-tools.cmp").lspkind_format,
--   }),
-- }



-- Evitar que LunarVim omita tsserver
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
  function(server) return server ~= "tsserver" end,
  lvim.lsp.automatic_configuration.skipped_servers
)

-- tsserver con navic  para React/NextJS
local navic = require("nvim-navic")
require("lvim.lsp.manager").setup("tsserver", {
  filetypes = { "typescript", "typescriptreact", "javascriptreact" },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end

    -- Deshabilitar formateo de tsserver ya que usamos prettier
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  init_options = {
    hostInfo = "neovim",
    preferences = {
      importModuleSpecifierPreference = "non-relative",
      includeCompletionsForImportStatements = true,
    },
  },
})

-- Asegúrate de que null-ls esté disponible para formateo
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- Registrar el null-ls como formateador para tipos de archivo React/NextJS
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- Prettier para formateo de código React/NextJS
    formatting.prettier.with({
      extra_filetypes = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
      prefer_local = "node_modules/.bin",
      -- Opciones para React/NextJS
      extra_args = {
        "--single-quote",
        "--jsx-single-quote",
        "--print-width", "100"
      },
    }),

    -- ESLint para diagnósticos
    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js" })
      end,
      prefer_local = "node_modules/.bin",
    }),

    -- ESLint para acciones de código
    code_actions.eslint_d,
  },
})

-- Indicar explícitamente a LunarVim qué formateador usar para los tipos de archivo React/NextJS
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    args = { "--single-quote", "--jsx-single-quote" },
    ---@usage specify which filetypes to enable. By default, providers will attach to all the filetypes they support.
    filetypes = {
      -- "javascript",
      "javascriptreact",
      -- "typescript",
      "typescriptreact",
      "css",
      "scss",
      "html",
      "json"
    },
  },
}

-- Asegúrate de que el formateo automático esté activo para estos tipos de archivo
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = {
  "*.js", "*.jsx", "*.ts", "*.tsx",
  "*.css", "*.scss", "*.html", "*.json"
}

-- LSP TailwindCSS con mejores opciones para React/NextJS
require("lvim.lsp.manager").setup("tailwindcss", {
  filetypes = {
    "html", "css", "scss",
    -- "javascript", "javascriptreact",
    "javascriptreact",
    "typescript", "typescriptreact"
  },
  init_options = {
    userLanguages = {
      javascript = "javascript",
      javascriptreact = "javascriptreact",
      typescript = "typescript",
      typescriptreact = "typescriptreact",
    }
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Para frameworks comunes de React/NextJS
          { "className\\s*=\\s*\"([^\"]*)\"",  "\"[^\"]*\"" },  -- className="..."
          { "className\\s*=\\s*'([^']*)'",     "'[^']*'" },     -- className='...'
          { "className\\s*=\\s*\\{([^}]*)\\}", "\\{[^}]*\\}" }, -- className={...}
          -- Para librerías de composición de clases
          "(?:clsx|classnames)\\(([^)]*)\\)"
        }
      },
      validate = true,
      includeLanguages = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
      },
    }
  },
})

-- Completado con íconos y soporte para tailwind-tools
lvim.builtin.cmp.formatting = {
  format = require("lspkind").cmp_format({
    before = require("tailwind-tools.cmp").lspkind_format,
  }),
}
