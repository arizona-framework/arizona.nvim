.PHONY: test lint format clean install help

# Default target
help:
	@echo "Available commands:"
	@echo "  test     - Run all tests"
	@echo "  lint     - Check code formatting"
	@echo "  format   - Format code with stylua"
	@echo "  health   - Run plugin health check"
	@echo "  install  - Install dependencies for local development"
	@echo "  clean    - Clean temporary files"
	@echo "  help     - Show this help message"

# Test the plugin
test:
	@echo "Running tests..."
	nvim --headless --noplugin -u tests/minimal_init.lua \
		-c "lua require('plenary.test_harness').test_directory('tests')"

# Check code formatting
lint:
	@echo "Checking code formatting..."
	stylua --check .

# Format code
format:
	@echo "Formatting code..."
	stylua .

# Run health check
health:
	@echo "Running health check..."
	nvim --headless -c "runtime! plugin/arizona.lua" -c "checkhealth arizona" -c "quit"

# Install development dependencies
install:
	@echo "Installing development dependencies..."
	@mkdir -p ~/.local/share/nvim/site/pack/dev/start
	@if [ ! -d ~/.local/share/nvim/site/pack/dev/start/plenary.nvim ]; then \
		echo "Installing plenary.nvim..."; \
		git clone https://github.com/nvim-lua/plenary.nvim \
			~/.local/share/nvim/site/pack/dev/start/plenary.nvim; \
	fi
	@if [ ! -d ~/.local/share/nvim/site/pack/dev/start/nvim-treesitter ]; then \
		echo "Installing nvim-treesitter..."; \
		git clone https://github.com/nvim-treesitter/nvim-treesitter \
			~/.local/share/nvim/site/pack/dev/start/nvim-treesitter; \
	fi
	@if [ ! -d ~/.local/share/nvim/site/pack/dev/start/otter.nvim ]; then \
		echo "Installing otter.nvim..."; \
		git clone https://github.com/jmbuhr/otter.nvim \
			~/.local/share/nvim/site/pack/dev/start/otter.nvim; \
	fi
	@echo "Dependencies installed!"

# Clean temporary files
clean:
	@echo "Cleaning temporary files..."
	@find . -name "*.tmp" -delete
	@find . -name ".DS_Store" -delete
	@echo "Clean complete!"

# CI target (used by GitHub Actions)
ci: lint test health
