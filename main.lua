
-- Some configuration
SHOWCOLLIDERS = false

-- Levels
local levels = require('levels')
local menus = require('menus')

-- Game-wide state
local Game = {}
local GameTools = require("GameTools")

function love.load()

    -- creation of the basic game world is in GameTools
    -- because that makes it easier to make "experiments/" that
    -- occur in the game world
    GameTools.initWorld(Game)

    if SHOWCOLLIDERS then 
        Game.world:setQueryDebugDrawing(true)
    end

    -- load the first scene
    -- menus.start(Game)
    levels.start(Game)
end
