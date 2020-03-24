
-- Some configuration
SHOWCOLLIDERS = false

-- Levels
local levels = require('levels')
local menus = require('menus')

-- Game-wide state
local Game = {}

-- Because of mid development changes, some places in the
-- game pass a ref of `world` and `entities` seperately and
-- other places simply pass `Game` which contains references
-- to both.
-- TODO, make it consistent and change all references to
-- `Game`.

local worldInitialize = require("worldInitializer")

function love.load()

    -- creation of the basic game world is in "worldInitialize"
    -- because that makes it easier to make "experiments/" that
    -- occur in the game world
    worldInitialize(Game)

    if SHOWCOLLIDERS then 
        Game.world:setQueryDebugDrawing(true)
    end

    -- load the first scene
    -- menus.start(Game)
    levels.start(Game)
end
