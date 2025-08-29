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
   Include jmbuhr/otter.nvim in your plugin manager dependencies
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

## Development

To test the local plugin during development:

```lua
{
  dir = "/path/to/arizona.nvim",
  name = "arizona.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "jmbuhr/otter.nvim",
  },
}
```

### Development Commands

```bash
# Install dependencies for local development
make install

# Run tests
make test

# Check code formatting
make lint

# Format code with stylua
make format

# Run health check
make health

# Clean temporary files
make clean

# Run all CI checks (lint + test + health)
make ci
```

## Troubleshooting

Run `:checkhealth arizona` to see what's working and what needs setup.

## License

Apache-2.0
