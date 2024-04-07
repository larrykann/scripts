local M = {}

function M.loadEnv(path)
    local env = {}
    for line in io.lines(path) do
        local key, value = line:match("^([^=]+)=(.+)$")
        if key and value then
            -- Remove leading and trailing whitespace from key
            key = key:match("^%s*(.-)%s*$")
            -- Remove leading and trailing quotes from value
            value = value:match('^%s*"(.-)"%s*$') or value:match("^%s*(.-)%s*$")
            env[key] = value
        end
    end
    return env
end

return M

