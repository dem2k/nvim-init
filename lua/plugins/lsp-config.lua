-- https://github.com/neovim/nvim-lspconfig
return {
  "neovim/nvim-lspconfig",
  -- opt = {}, -- same as require("blabla").setup({}) ?
  dependencies = {
    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = {} },
    -- Additional lua configuration, makes nvim stuff amazing!
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local lspdefault = lspconfig.util.default_config

    lspdefault.capabilities = vim.tbl_deep_extend(
      "force", lspdefault.capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP Actions",
      callback = function(event)
        vim.lsp.set_log_level("debug")
        local opts = { buffer = event.buf }
        -- lsp keymaps
        vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", ":lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", ":lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<cr>", opts)
        -- lsp actions
        vim.keymap.set("n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set("n", "<leader>lj", ":lua vim.diagnostic.goto_next()<cr>", opts)
        vim.keymap.set("n", "<leader>lk", ":lua vim.diagnostic.goto_prev()<cr>", opts)
        vim.keymap.set("n", "<leader>lh", ":lua vim.lsp.buf.hover()<cr>", { desc = "Hover Documentation" })
        vim.keymap.set("n", "<leader>lf", ":lua vim.lsp.buf.format({})<cr>", { desc = "Format current Buffer" })
        vim.keymap.set({"n","v"}, "<leader>la", ":lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action..." })
      end
    })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          },
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim", },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", false),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        }
      }
    })

    -- powershell
    local pwsh_lsp_path = vim.fn.stdpath("data") .. "/lsp/powershell"
    lspconfig.powershell_es.setup({
      -- shell = "powershell.exe",
      -- bundle_path = pwsh_lsp_path,
      cmd = { vim.env.SCOOP .. "/apps/pwsh/current/pwsh.exe", "-NoLogo", "-NoProfile", "-Command",
        "& " .. pwsh_lsp_path .. "/PowerShellEditorServices/Start-EditorServices.ps1"
        .. " -BundledModulesPath '" .. pwsh_lsp_path .. "'"
        .. " -LogLevel 'Diagnostic' -LogPath '" .. vim.fn.stdpath("data") .. "/powershell.log'"
        .. " -SessionDetailsPath '" .. vim.fn.stdpath("data") .. "/powershell.session.json'"
        .. " -FeatureFlags @() -AdditionalModules @()"
        -- .. " -HostName 'nvim' -HostProfileId 'nvim' -HostVersion '1.0.0' -Stdio"
        .. " -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio"
        -- .. " -HostName 'nvim' -HostProfileId 0 -HostVersion '1.0.0' -Stdio"
      },
      root_dir = function(fname)
        return lspconfig.util.root_pattern(".git")(fname) or vim.fn.getcwd()
      end
    }) -- end powershell

    -- java
    local jdtls_home = vim.fn.stdpath("data") .. "/lsp/java"
    local jdtls_config = jdtls_home .. "/config_win"
    local jdtls_launcher = jdtls_home .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
    lspconfig.jdtls.setup {
      cmd = {
        --
        vim.env.JAVA_HOME .. "/bin/java.exe",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",

        -- " -Dosgi.checkConfiguration=true",
        -- " -Dosgi.sharedConfiguration.area='c:/users/dkl/appdata/local/nvim-data/lsp/java/config_win'",
        -- " -Dosgi.sharedConfiguration.area.readOnly=true",
        -- " -Dosgi.configuration.cascaded=true",
        -- " -noverify",

        "-Dlog.level=ALL", "-Dlog.protocol=true",
        "-Xms1g", "-Xmx4g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        --
        "-javaagent:" .. jdtls_home .. "/lombok.jar",
        --
        "-jar", jdtls_launcher,
        "-configuration", jdtls_config,
        -- "-data", (vim.fs.dirname(vim.fs.find({"pom.xml"}, { upward = true })[1]) or vim.fn.getcwd()) .. "/.jdtls"
        "-data", vim.env.temp .. "/.jdtls"
      },
      settings = {
        java = {
          home = vim.env.JAVA_HOME,
          signatureHelp = { enabled = true },
          import = { enabled = true },
          rename = { enabled = true },
          eclipse = { downloadSources = true, },
          maven = { downloadSources = true, },

        }
      },
      init_options = {
        bundles = {}
      },

      -- root_dir = function()
      --   return {
      --         "pom.xml", -- Maven
      --         "build.xml", -- Ant
      --       }          -- Multi-module projects { "build.gradle", "build.gradle.kts" },
      --       -- or vim.fn.getcwd()
      -- end,

      single_file_support = true,
    }
    -- lspconfig.jdtls.setup().find_root({ "pom.xml" })
    -- require("jdtls.setup").find_root({ "pom.xml" })

    -- local cmp = require("cmp")
    -- cmp.setup({
    --   mapping = {
    --     ["<CR>"] = cmp.mapping.confirm({ select = false }),
    --   }
    -- })

    -- end config function
  end,
}
