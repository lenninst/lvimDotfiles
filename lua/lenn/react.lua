lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(
  function(server) return server ~= "tsserver" end,
  lvim.lsp.automatic_configuration.skipped_servers
)

local navic = require("nvim-navic")

require("lvim.lsp.manager").setup("tsserver", {
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end,
  init_options = {
    hostInfo = "neovim"
  }
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Formateo con prettier
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "json", "html", "css", "markdown"
      },
    }),
    -- Linting con eslint
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.json" }) -- o .eslintrc.js
      end,
    }),
    -- Auto fix con eslint
    null_ls.builtins.code_actions.eslint_d,
  },
})


require("lvim.lsp.manager").setup("tailwindcss", {
  filetypes = {
    "html", "css", "scss", "javascript", "javascriptreact",
    "typescript", "typescriptreact", "typescript.tsx"
  },
  init_options = {
    userLanguages = {
      ["javascript"] = "javascript",
      ["javascriptreact"] = "javascriptreact",
      ["typescript"] = "typescript",
      ["typescriptreact"] = "typescriptreact",
    }
  },
})

lvim.builtin.cmp.formatting = {
  format = require("lspkind").cmp_format({
    before = require("tailwind-tools.cmp").lspkind_format
  }),
}

-- snipets
ls.snippets = {
  tsx = {
    -- Snippet para la etiqueta div
    s("div", {
      t("<div></div>"),
    }),
    -- Snippet para p
    s("p", {
      t("<p></p>"),
    }),
    -- Snippet para span
    s("span", {
      t("<span></span>"),
    }),
    -- Puedes seguir agregando más snippets aquí
  },
}

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  sources = cmp.config.sources({
    { name = "luasnip" }, -- Asegúrate de tener la fuente de LuaSnip aquí
  }),
})
