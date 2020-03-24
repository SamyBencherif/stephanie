-- Entity imports
local Button = require "entities/menu/button"

local Object = require("libraries/classic/classic")

local assets = require("libraries/cargo/cargo").init("assets")

-- Unit constants
    -- World width
    local W = 512
    -- World height
    local H = 512
    -- Block size (both dim)
    local B = 64

    -- (Derived) : these are now hardcoded, 
    -- please ensure they are consistent with above
    -- Half of world width
    local W2 = 512/2
    -- Half of world height
    local H2 = 512/2
    -- Half of block size (both dim)
    local B2 = 64/2
    -- Blocks per world width
    local WB = W/B
    -- Block per world height
    local HB = H/B
    -- Block size without border,
    -- useful so I can tightly
    -- pack them together
    local b = B-12

    -- I am also defining these constants
    -- They are useful for placing Ground primitives,
    -- since they use half blocks.

    -- Half blocks per world width
    local WB2 = WB*2
    -- Half blocks per world height
    local HB2 = HB*2

-- Levels are listed in reverse order because each level
-- must have a reference to the one it will spawn

function start(Game)

    local entities = Game.entities
    local world = Game.world

    entities[#entities+1] = Button(Game, W/2, H/2)
end

return {start=start}
