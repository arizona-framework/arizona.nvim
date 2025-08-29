-- Arizona Framework Health Check

local M = {}

function M.check()
  local health = vim.health

  health.start("Arizona Framework")

  -- Core feature: Filetype detection (always works)
  if vim.filetype.match({ filename = "test.herl" }) == "arizona" then
    health.ok("Filetype detection working (.herl → arizona)")
  else
    health.error("Filetype detection broken")
  end

  -- Feature: Tree-sitter parser
  local ts_ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if ts_ok then
    if parsers.get_parser_configs().arizona then
      health.ok("Tree-sitter parser configured")

      -- Check if parser is actually installed
      local parser_ok =
        pcall(vim.treesitter.get_parser, vim.api.nvim_create_buf(false, true), "arizona")
      if parser_ok then
        health.ok("Arizona parser installed and working")
      else
        health.warn("Arizona parser configured but not installed - run :TSInstall arizona")
      end
    else
      health.error("Tree-sitter parser not configured")
    end
  else
    health.warn("nvim-treesitter not available")
  end

  -- Feature: Language injection
  if pcall(require, "otter") then
    health.ok("Language injection available (otter.nvim found)")
  else
    health.warn("Language injection unavailable (install otter.nvim)")
  end

  -- Current buffer status
  local current_ft = vim.bo.filetype
  if current_ft == "arizona" then
    health.start("Current Buffer")
    health.ok("Current buffer is Arizona template file")
  end
end

return M
