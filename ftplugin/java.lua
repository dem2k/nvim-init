   local jdtls_home = vim.fn.stdpath("data") .. "/lsp/java"
    local jdtls_config = jdtls_home .. "/config_win"
    local jdtls_launcher = jdtls_home .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
   local config = {
    root_dir = require('jdtls.setup').find_root({'pom.xml'}),
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
        "-javaagent:" .. vim.env.HOME .. "/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar",
        --
        "-jar", jdtls_launcher,
        "-configuration", jdtls_config,
        "-data", "y:/-tmp-"
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
      },  }

require('jdtls').start_or_attach(config)

