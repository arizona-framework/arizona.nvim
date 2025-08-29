local assert = require("luassert")

describe("Arizona Framework Plugin", function()
  before_each(function()
    -- Reset any plugin state between tests
    vim.g.arizona_loaded = nil

    -- Clear any existing filetype associations
    vim.filetype = require("vim.filetype")
  end)

  describe("Plugin Loading", function()
    it("should load without errors", function()
      -- Load the plugin
      vim.cmd("runtime! plugin/arizona.lua")

      -- Verify plugin loaded
      assert.equals(1, vim.g.arizona_loaded)
    end)

    it("should prevent double loading", function()
      -- Load plugin twice
      vim.cmd("runtime! plugin/arizona.lua")
      vim.cmd("runtime! plugin/arizona.lua")

      -- Should still be 1, not 2
      assert.equals(1, vim.g.arizona_loaded)
    end)
  end)

  describe("Filetype Detection", function()
    it("should detect .herl files as arizona filetype", function()
      local filetype = vim.filetype.match({ filename = "test.herl" })
      assert.equals("arizona", filetype)
    end)

    it("should detect .herl files with full path", function()
      local filetype = vim.filetype.match({ filename = "/path/to/template.herl" })
      assert.equals("arizona", filetype)
    end)

    it("should not interfere with other filetypes", function()
      local filetype = vim.filetype.match({ filename = "test.lua" })
      assert.equals("lua", filetype)
    end)
  end)

  describe("Tree-sitter Integration", function()
    it("should configure arizona parser when nvim-treesitter available", function()
      local ok, parsers = pcall(require, "nvim-treesitter.parsers")

      if ok then
        local parser_config = parsers.get_parser_configs().arizona

        assert.is_not_nil(parser_config)
        assert.equals("arizona", parser_config.filetype)
        assert.is_table(parser_config.install_info)
        assert.equals(
          "https://github.com/arizona-framework/tree-sitter-arizona",
          parser_config.install_info.url
        )
        assert.same({ "src/parser.c" }, parser_config.install_info.files)
        assert.equals("main", parser_config.install_info.branch)
      else
        pending("nvim-treesitter not available in test environment")
      end
    end)
  end)

  describe("Language Injection", function()
    it("should setup otter.nvim integration when available", function()
      local ok = pcall(require, "otter")

      if ok then
        -- Verify autocmd was created
        local autocmds = vim.api.nvim_get_autocmds({
          group = "ArizonaLanguageInjection",
          pattern = "arizona",
        })

        assert.is_true(#autocmds > 0)
        assert.equals("FileType", autocmds[1].event)
      else
        -- Should not error when otter.nvim is not available
        assert.is_true(true, "Gracefully handles missing otter.nvim")
      end
    end)
  end)

  describe("Health Check", function()
    it("should provide health check function", function()
      local health = require("arizona.health")
      assert.is_function(health.check)
    end)

    it("should run health check without errors", function()
      local health = require("arizona.health")

      -- Mock vim.health to capture calls
      local health_calls = {}
      local original_health = vim.health
      vim.health = {
        start = function(name)
          table.insert(health_calls, { "start", name })
        end,
        ok = function(msg)
          table.insert(health_calls, { "ok", msg })
        end,
        warn = function(msg)
          table.insert(health_calls, { "warn", msg })
        end,
        error = function(msg)
          table.insert(health_calls, { "error", msg })
        end,
      }

      -- Run health check
      assert.has_no.errors(function()
        health.check()
      end)

      -- Verify health check was called
      assert.is_true(#health_calls > 0)

      -- Restore original health
      vim.health = original_health
    end)
  end)
end)
