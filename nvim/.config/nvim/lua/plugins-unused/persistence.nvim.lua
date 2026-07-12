-- Lua
return {
  "folke/persistence.nvim",
  event = "VimEnter",
  opts = {
    -- add any custom options here
  },
  config = function(_, opts)
          require("persistence").setup(opts)

          if vim.fn.argc() == 0 then
                  require("persistence").load()
          end
  end,
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "恢复当前目录会话" },
    { "<leader>qS", function() require("persistence").select() end, desc = "选择会话加载" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "恢复上一个会话" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "停止保存本次会话" },
  },
}
