-- Arizona Framework Neovim Plugin
-- Auto-activating language support for .herl template files

-- Prevent double loading
if vim.g.arizona_loaded then
  return
end
vim.g.arizona_loaded = 1

-- Core feature: Filetype detection
vim.filetype.add({
  extension = { herl = "arizona" },
})

-- Feature: Tree-sitter parser registration
local function setup_treesitter()
  local ok, parser_config = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    return
  end

  local parsers = parser_config.get_parser_configs()
  parsers.arizona = {
    install_info = {
      url = "https://github.com/arizona-framework/tree-sitter-arizona",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "arizona",
  }
end

-- Feature: Language injection via otter.nvim
local function setup_language_injection()
  local ok, otter = pcall(require, "otter")
  if not ok then
    return
  end

  -- Auto-activate on Arizona files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "arizona",
    group = vim.api.nvim_create_augroup("ArizonaLanguageInjection", { clear = true }),
    callback = function()
      otter.activate({ "html", "erlang" }, true)
    end,
  })
end

-- Auto-setup all features
setup_treesitter()
setup_language_injection()
