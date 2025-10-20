return {
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "folke/snacks.nvim",
      },
      lazy = false,
      ---@module "neo-tree"
      ---@type neotree.Config?
      opts = {
          filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
            hijack_netrw_behavior = "open_default",
          },
          window = {
            mappings = {
              ["<space>"] = "none",
              ["Y"] = {
                function(state)
                  local node = state.tree:get_node()
                  local path = node:get_id()
                  vim.fn.setreg("+", path, "c")
                end,
                desc = "Copy Path to Clipboard",
              },
              ["O"] = {
                function(state)
                  require("lazy.util").open(state.tree:get_node().path, { system = true })
                end,
                desc = "Open with System Application",
              },
              ["P"] = { "toggle_preview", config = { use_float = false } },
            },
          },
      },
      keys = {
          -- {
          --   "<leader>e",
          --   function()
          --     require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
          --   end,
          --   desc = "Explorer NeoTree (Root Dir)",
          -- },
          {
            "<leader>e",
            function()
              require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
          },
          {
            "<leader>be",
            function()
              require("neo-tree.command").execute({ source = "buffers", toggle = true })
            end,
            desc = "Buffer Explorer",
          },
      },
    }
}
