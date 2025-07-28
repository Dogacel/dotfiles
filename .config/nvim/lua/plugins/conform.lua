return {
  {
    "stevearc/conform.nvim",
    optional = true,
    enabled = false,
    opts = {
      formatters_by_ft = { kotlin = { "ktlint" } },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { kotlin = { } },
    },
  }
}
