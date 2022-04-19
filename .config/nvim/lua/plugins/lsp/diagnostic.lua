local M = {}

local namespaces_without_signs = {}

local function reset_diagnostic()
    vim.diagnostic.reset(nil, 0)
    package.loaded['vim.diagnostic'] = nil
    vim.diagnostic = require 'vim.diagnostic'
end

local function separate_and_sort(diagnostics)
    local severity = vim.diagnostic.severity
    local linter = {
        [severity.ERROR] = {},
        [severity.WARN] = {},
        [severity.INFO] = {},
        [severity.HINT] = {},
    }
    local lsp = {
        [severity.ERROR] = {},
        [severity.WARN] = {},
        [severity.INFO] = {},
        [severity.HINT] = {},
    }
    for _, diagnostic in ipairs(diagnostics) do
        local list = vim.tbl_contains(namespaces_without_signs, diagnostic.namespace) and linter or lsp
        table.insert(list[diagnostic.severity], diagnostic)
    end
    return linter, lsp
end

return M
