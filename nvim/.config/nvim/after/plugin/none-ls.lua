local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.beautysh,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.htmlhint,
        null_ls.builtins.diagnostics.cpplint,
        null_ls.builtins.diagnostics.angularls,
        null_ls.builtins.diagnostics.pylsp,
        null_ls.builtins.diagnostics.bashls,
        null_ls.builtins.diagnostics.lua_ls,
        null_ls.builtins.diagnostics.tsserver,
        null_ls.builtins.diagnostics.astro,
        null_ls.builtins.diagnostics.html,
    },
})
