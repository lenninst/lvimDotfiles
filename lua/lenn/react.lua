
-- Evitar que LunarVim omita tsserver
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
  function(server) return server ~= "tsserver" end,
  lvim.lsp.automatic_configuration.skipped_servers
)

-- tsserver con navic
local navic = require("nvim-navic")
require("lvim.lsp.manager").setup("tsserver", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end,
  init_options = { hostInfo = "neovim" },
})

-- none-ls para prettier y eslint_d
local none_ls = require("none-ls")
none_ls.setup({
  sources = {
    none_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "html", "css", "markdown" },
    }),
    none_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js" })
      end,
    }),
    none_ls.builtins.code_actions.eslint_d,
  },
})

-- LSP TailwindCSS
require("lvim.lsp.manager").setup("tailwindcss", {
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  init_options = {
    userLanguages = {
      javascript = "javascript",
      javascriptreact = "javascriptreact",
      typescript = "typescript",
      typescriptreact = "typescriptreact",
    }
  },
})

-- Completado con íconos y soporte para tailwind-tools
lvim.builtin.cmp.formatting = {
  format = require("lspkind").cmp_format({
    before = require("tailwind-tools.cmp").lspkind_format,
  }),
}
