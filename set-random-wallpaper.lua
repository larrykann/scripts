#!/usr/bin/env lua

-- Path to your wallpapers directory
local envLoader = require("env_loader")
local env = envLoader.loadEnv("./.env")

local wallpapersPath = env["WALLPAPER_PATH"]
if not wallpapersPath then
    print("Error: WALLPAPER_PATH is not set.")
    os.exit(1)
end

-- Function to get files from a directory
function getFilesFromDir(directory)
    local i, fileList, popen = 0, {}, io.popen
    for filename in popen('ls -a "'..directory..'"'):lines() do
        if filename ~= "." and filename ~= ".." then
            i = i + 1
            fileList[i] = filename
        end
    end
    return fileList
end

-- Function to set a random wallpaper
function setRandomWallpaper(path)
    local files = getFilesFromDir(path)
    if #files == 0 then return end
    local randomNumber = math.random(#files)
    local wallpaper = files[randomNumber]
    os.execute('feh --bg-scale "'..path..'/'..wallpaper..'"')
end

-- Set the seed for the random generator
math.randomseed(os.time())

-- Call the function
setRandomWallpaper(wallpapersPath)
