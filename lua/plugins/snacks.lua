return {
  "folke/snacks.nvim",
  -- priority = 1000,
  -- lazy = false,
  -- @type snacks.Config
  opts = {

    picker = {
      sources = {
        explorer = {
          layout = {
            auto_hide = { "input" },
          },
        },
      },

      win = {
        input = {
          keys = {
            ["<a-c>"] = { "cycle_preview", mode = { "i", "n" } },
          },
        },
      },

      actions = {
        cycle_preview = function(picker)
          local layout_config = vim.deepcopy(picker.resolved_layout)
          if layout_config.preview == "main" or not picker.preview.win:valid() then
            return
          end

          local function find_preview(root) ---@param root snacks.layout.Box|snacks.layout.Win
            if root.win == "preview" then
              return root
            end
            if #root then
              for _, w in ipairs(root) do
                local preview = find_preview(w)
                if preview then
                  return preview
                end
              end
            end
            return nil
          end

          local preview = find_preview(layout_config.layout)

          if not preview then
            return
          end

          local eval = function(s)
            return type(s) == "function" and s(preview.win) or s
          end
          --- @type number?, number?
          local width, height = eval(preview.width), eval(preview.height)

          if not width and not height then
            return
          end

          local cycle_sizes = { 0.1, 0.9 }
          local size_prop, size

          if height then
            size_prop, size = "height", height
          else
            size_prop, size = "width", width
          end

          picker.init_size = picker.init_size or size ---@diagnostic disable-line: inject-field
          table.insert(cycle_sizes, picker.init_size)
          table.sort(cycle_sizes)

          for i, s in ipairs(cycle_sizes) do
            if size == s then
              local smaller = cycle_sizes[i - 1] or cycle_sizes[#cycle_sizes]
              preview[size_prop] = smaller
              break
            end
          end

          for i, h in ipairs(layout_config.hidden) do
            if h == "preview" then
              table.remove(layout_config.hidden, i)
            end
          end

          picker:set_layout(layout_config)
        end,
      },
    },

    indent = {
      animate = {
        enabled = false,
      },
    },
  },
}
