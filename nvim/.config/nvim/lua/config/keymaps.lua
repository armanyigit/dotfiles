-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ss = require('smart-splits')
vim.keymap.set({ 'n', 't' }, '<C-h>', ss.move_cursor_left)
vim.keymap.set({ 'n', 't' }, '<C-j>', ss.move_cursor_down)
vim.keymap.set({ 'n', 't' }, '<C-k>', ss.move_cursor_up)
vim.keymap.set({ 'n', 't' }, '<C-l>', ss.move_cursor_right)
