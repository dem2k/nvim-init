-- if true then return {} end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim",           opts = {} },
        { "williamboman/mason-lspconfig.nvim", opts = {} },
        { "j-hui/fidget.nvim",                 opts = {} }, -- Useful status updates for LSP
        { "folke/neodev.nvim",                 opts = {} }, -- Additional lua configuration, makes nvim stuff amazing!
        -- { "mfussenegger/nvim-jdtls",            }, 
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        local lspconfig = require("lspconfig")
        local lspdefault = lspconfig.util.default_config

        lspdefault.capabilities = vim.tbl_deep_extend(
            "force", lspdefault.capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            -- group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            desc = "xxx-todo-desc-xxx",
            callback = function(event)
                -- vim.lsp.set_log_level("debug")
                local keymap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                keymap("gD", ":lua vim.lsp.buf.declaration()<cr>", "Goto Declaration")
                -- keymap("gD", require("telescope.builtin").declaration, "Goto Declaration")
                keymap("gd", ":lua vim.lsp.buf.definition()<cr>", "Goto Definition")
                -- keymap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
                keymap("gI", ":lua vim.lsp.buf.implementation()<cr>", "Goto Implementation")
                -- keymap("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
                keymap("gr", ":lua vim.lsp.buf.references()<cr>", "Goto References")
                -- keymap("gr", require("telescope.builtin").lsp_references, "Goto References")
                keymap("go", ":lua vim.lsp.buf.type_definition()<cr>", "Type Definition")
                -- keymap("go", require("telescope.builtin").lsp_type_definitions, "Type Definition")
                keymap("<leader>ls", ":lua vim.lsp.buf.signature_help()<cr>", "Signature Help")
                -- keymap("<leader>ls", require("telescope.builtin").signature_help, "Signature Help")
                keymap("<leader>lr", ":lua vim.lsp.buf.rename()<cr>", "Rename")
                -- keymap("<leader>lr", require("telescope.builtin").rename, "Rename")
                keymap("<leader>lj", ":lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic Message")
                -- keymap("<leader>lj", require("telescope.builtin").diagnostics.goto_next, "Next Diagnostic Message")
                keymap("<leader>lk", ":lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic Message")
                -- keymap("<leader>lk", require("telescope.builtin").diagnostic.goto_prev , "Previous Diagnostic Message")
                keymap('<leader>le', ":lua vim.diagnostic.open_float()<cr>", "Show Diagnostic Error Messages" )
                -- keymap('<leader>le', require("telescope.builtin").diagnostic.open_float, "Show Diagnostic Error Messages" )
                keymap('<leader>lq', ":lua vim.diagnostic.setloclist()<cr>", "Open Diagnostic Quickfix List" )
                -- keymap('<leader>lq', require("telescope.builtin").diagnostic.setloclist, "Open Diagnostic Quickfix List" )
                keymap("<leader>lh", ":lua vim.lsp.buf.hover()<cr>",  "Hover Documentation" )
                -- keymap("<leader>lh", require("telescope.builtin").hover,  "Hover Documentation" )
                keymap("<leader>lf", ":lua vim.lsp.buf.format({})<cr>",  "Format current Buffer" )
                -- keymap("<leader>lf", require("telescope.builtin").format,  "Format current Buffer" )
                keymap("<leader>ld", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
                keymap("<leader>lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
                vim.keymap.set({ "n", "v" }, "<leader>ll", ":lua vim.lsp.buf.code_action()<cr>", { buffer = event.buf, desc = "LSP: Code Action..." })
                -- vim.keymap.set({ "n", "v" }, "<leader>ll", require("telescope.builtin").code_action, { buffer = event.buf, desc = "LSP: Code Action..." })
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
        local pwsh_lsp_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
        lspconfig.powershell_es.setup({
            -- shell = "powershell.exe",
            -- bundle_path = pwsh_lsp_path,
            settings = {
                powershell = {
                    codeFormatting = { Preset = 'OTBS' },
                    scriptAnalysis = { settingsPath = vim.fn.stdpath("data") .. "/PSScriptAnalyzerSettings.psd1" },
                }
            },
            cmd = { vim.env.SCOOP .. "/apps/pwsh/current/pwsh.exe", "-NoLogo", "-NoProfile", "-Command",
                -- "& " ..
                pwsh_lsp_path .. "/PowerShellEditorServices/Start-EditorServices.ps1"
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
            end,
            on_attach = function(client, bufnr)
                vim.keymap.set('n', '<Leader>r', ":w | !powershell.exe ./%<cr>",
                    { buffer = bufnr, desc = "Save and Run Powershell." })
            end
        }) -- end powershell

    end
}
