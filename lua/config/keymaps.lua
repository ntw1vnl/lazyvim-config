-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "x", '"_x', { desc = "Delete single character without copying into register" })

-- Vertical scroll and center
keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Find and center
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<leader>y", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%:p"))
end, { desc = "Copy filename+line to clipboard" })
