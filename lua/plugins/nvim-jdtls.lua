-- if true then return {} end

-- actually using mini.comment, not this plugin
-- https://github.com/numToStr/Comment.nvim
return {
     "mfussenegger/nvim-jdtls",            
    ft = { "java" },
    config = function()

             -- java, last version of jdtls supports java 11 should be 1.12.0. how to download and install this particular verstion with mason? goddamn!
        local jdtls_home = vim.env.JDTLS_HOME or (vim.fn.stdpath("data") .. "/mason/packages/jdtls")
        local jdtls_config = jdtls_home .. "/config_win"
        local jdtls_launcher = jdtls_home .. "/plugins/"
            .. (vim.env.JDTLS_LAUNCHER or "org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar")

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
        require('jdtls').start_or_attach({
      -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        --   
       vim.env.JAVA_HOME .. "/bin/java.exe",
--
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true', '-Dlog.level=ALL',
        '-Xmx1g' , "-Xmx4g",
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--
       "-javaagent:" .. jdtls_home .. "/lombok.jar",
       "-jar", jdtls_launcher,
        --   
        "-configuration", jdtls_config,
      --   
        -- See `data directory configuration` section in the README
       "-data", vim.env.temp .. "/.jdtls"
    },

    --   
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ 'pom.xml', 'mvnw', 'gradlew' }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
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

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
      --     single_file_support = true,

        })
    end
}


