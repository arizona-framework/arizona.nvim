-- Minimal init for testing
-- This file is used by plenary to set up the testing environment

-- Add current plugin to runtime path
vim.opt.runtimepath:prepend(vim.fn.getcwd())

-- Add plenary to runtime path (should be available in CI)
vim.opt.runtimepath:prepend("~/.local/share/nvim/site/pack/plenary/start/plenary.nvim")

-- Add optional dependencies to runtime path
vim.opt.runtimepath:prepend("~/.local/share/nvim/site/pack/treesitter/start/nvim-treesitter")
vim.opt.runtimepath:prepend("~/.local/share/nvim/site/pack/otter/start/otter.nvim")

-- Load the plugin
vim.cmd("runtime! plugin/arizona.lua")
