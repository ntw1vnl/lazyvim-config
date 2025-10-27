return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      float = {
        border = "rounded",
      },
    },
    servers = {
      ["*"] = {
        keys = {
          -- disable gr keymap for lsp (used by mini.operators replace)
          { "gr", false },
        },
      },
      qmlls = {
        cmd = {
          "qmlls",
          "-E",
        },
      },
      -- qmlls = {
      --   mason = false,
      --   cmd = {
      --     vim.fn.expand("~/tools/qmlls/0.5/qmlls"),
      --   },
      -- },
    },
  },
}
