local M = {}

local mason = require 'mason'

function M.run(servers, force)
    local uninstalled_servers = vim.tbl_filter(function(server)
        return force or server and not server:is_installed()
    end, vim.tbl_map(function(s)
        local ok, server = mason.get_server(s)
        return ok and server
    end, servers))
    for _, server in ipairs(uninstalled_servers) do
        server:install()
        print(server.name .. 'has been installed.')
    end
end

return M
