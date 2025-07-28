return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    -- set keymaps for search without gitignore restrictions
    {
      "<leader>fa",
      function()
        require("telescope.builtin").find_files({
          cwd = false,
        })
      end,
      desc = "Find All (cwd)",
    },
    {
      "<leader>fA",
      function()
        require("telescope.builtin").find_files({})
      end,
      desc = "Find All (Root dir)",
    },
    {
      "<leader>sf",
      function()
        require("telescope.builtin").live_grep({
          additional_args = {
            "--no-ignore-vcs",
          },
          cwd = false,
        })
      end,
      desc = "Grep All (cwd)",
    },
    {
      "<leader>sF",
      function()
        require("telescope.builtin").live_grep({
          additional_args = {
            "--no-ignore-vcs",
          },
        })
      end,
      desc = "Grep All (Root dir)",
    },
    {
      "<leader>sv",
      function()
        require("telescope.builtin").live_grep({
          cwd = false,
        })
      end,
      desc = "Word All (cwd)",
    },
    {
      "<leader>sV",
      function()
        require("telescope.builtin").live_grep({})
      end,
      desc = "Word All (Root dir)",
    },
  },
  config = function()
    require("telescope").setup({
      pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!**/.git/*" }
          end,
        },
        grep_string = {
          additional_args = function()
            return { "--hidden", "--glob", "!**/.git/*" }
          end,
        },
      },
    })
  end,
}
