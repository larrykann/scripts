local function loadEnv(filePath)
    local env = {}
    local file, err = io.open(filePath, "r")

    if not file then
        print("Could not open the .env file: " .. err)
        return env
    end

    for line in file:lines() do
        local key, value = line:match("^([^=]+)=(.+)$")
        if key and value then
            env[key] = value
        end
    end

    file:close()
    return env
end

return loadEnv
