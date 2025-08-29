# Arizona Framework Neovim Plugin

Language support for Arizona Framework template files (`.herl`).

## What it provides

- **Filetype detection**: `.herl` files automatically recognized as `arizona` filetype
- **Syntax highlighting**: Tree-sitter parser for Arizona template syntax
- **Language injection**: HTML and Erlang completion within template files

## Installation

### Using lazy.nvim

```lua
{
  'arizona-framework/arizona.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'jmbuhr/otter.nvim', -- Optional: for HTML/Erlang completion
  },
}
```

### Using packer.nvim

```lua
use {
  'arizona-framework/arizona.nvim',
  requires = {
    'nvim-treesitter/nvim-treesitter',
    'jmbuhr/otter.nvim', -- Optional
  },
}
```

## Setup

**No configuration needed!** The plugin auto-activates when installed.

## Getting full functionality

1. **Install the tree-sitter parser** (for syntax highlighting):
   ```
   :TSInstall arizona
   ```

2. **Install otter.nvim** (for HTML/Erlang completion in template files):
   ```
   Already listed as dependency above
   ```

3. **Check everything is working**:
   ```
   :checkhealth arizona
   ```

## Requirements

- Neovim 0.9+
- nvim-treesitter (required dependency)
- otter.nvim (optional, for language injection)

## LSP Setup

Configure your Erlang LSP separately. Example:

```lua
require('lspconfig').elp.setup({
  -- Your ELP configuration
})
```

## Troubleshooting

Run `:checkhealth arizona` to see what's working and what needs setup.

## License

Apache-2.0
