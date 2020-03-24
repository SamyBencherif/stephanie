-- Entity imports
local Player = require "entities/player"
local Entity = require "entities/entity"
local Prop = require "entities/prop"
local Flag = require "entities/flag"
local Block = require "entities/block"
local Ground = require "entities/ground"

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

function levelFive(Game)
    local entities = Game.entities
    local world = Game.world

    -- Create the player and Entry door
    -- spawn coords rel to bottom of player
    local spawnX = 0
    local spawnY = H-B2
    entities[#entities+1] = Prop(world, assets.smalldoor, spawnX, spawnY - B)
    entities[#entities+1] = Player(world, spawnX+16, spawnY - 2*B, entities)
    
    -- right side
    entities[#entities+1] = Block(world, "freq0", W-B, H-B2-2*B)
    entities[#entities+1] = Block(world, "freq0", W-B-b, H-B2-2*B)
    entities[#entities+1] = Block(world, "freq0", W-B-2*b, H-B2-2*B)

    -- blockade #1
    entities[#entities+1] = Block(world, "freqA", W2-B2, H-B2-2*B)
    entities[#entities+1] = Block(world, "freqA", W2-B2, H-B2-2*B-b)

    -- left side
    entities[#entities+1] = Block(world, "freq0", 2*b, H-B2-4*B)
    entities[#entities+1] = Block(world, "freq0", b, H-B2-4*B)
    entities[#entities+1] = Block(world, "freq0", 0, H-B2-4*B)

    -- blockade #2
    entities[#entities+1] = Block(world, "freqB", W2-B2, H-B2-3*B-b)
    entities[#entities+1] = Block(world, "freqB", W2-B2, H-B2-3*B-2*b)

    -- right side
    entities[#entities+1] = Block(world, "freq0", W-B, B)
    entities[#entities+1] = Block(world, "freq0", W-B-b, B)
    entities[#entities+1] = Block(world, "freq0", W-B-2*b, B)

    entities[#entities+1] = Flag(Game, W-B, 0, levelSix)
end

function levelFour(Game)
    local entities = Game.entities
    local world = Game.world

    -- Create the player and Entry door
    -- spawn coords rel to bottom of player
    local spawnX = W2-B2
    local spawnY = H-B2
    -- Here the door and player are slightly offset
    entities[#entities+1] = Prop(world, assets.smalldoor, spawnX-B2, spawnY - B)
    entities[#entities+1] = Player(world, spawnX+16+B2, spawnY - 2*B, entities)

    for i=0,6 do
        entities[#entities+1] = Block(world, "freq0", W2-B2-2*B, H-B2-B-i*b)
        entities[#entities+1] = Block(world, "freq0", W2-B2+2*B, H-B2-B-i*b)
        if i % 3 == 2 then
            entities[#entities+1] = Block(world, "freqA", W2-B2-B, H-B2-B-i*b)
            entities[#entities+1] = Block(world, "freqA", W2-B2, H-B2-B-i*b)
            entities[#entities+1] = Block(world, "freqA", W2-B2+B, H-B2-B-i*b)
        end
    end

    entities[#entities+1] = Flag(Game, W2-B2, H-B2-2*B-5*b, levelFive)
end

function levelThree(Game)

    local entities = Game.entities
    local world = Game.world

    -- Create the player and Entry door
    -- spawn coords rel to bottom of player
    local spawnX = 0
    local spawnY = H-B2
    entities[#entities+1] = Prop(world, assets.smalldoor, spawnX, spawnY - B)
    entities[#entities+1] = Player(world, spawnX+16, spawnY - 2*B, entities)

    entities[#entities+1] = Block(world, "freq0", W2-B2, H-B2-2*B-b)

    -- TODO crop texture so no overlap when semi-transparent
    entities[#entities+1] = Block(world, "freqA", W2-B2, H-B2-B-b)
    entities[#entities+1] = Block(world, "freqA", W2-B2, H-B2-B)

    entities[#entities+1] = Flag(Game, W-B, H-B2-B, levelFour)
end

function levelTwo(Game)

    local entities = Game.entities
    local world = Game.world

    -- Create the player and Entry door
    -- spawn coords rel to bottom of player
    local spawnX = 0
    local spawnY = H-B2
    entities[#entities+1] = Prop(world, assets.smalldoor, spawnX, spawnY - B)
    entities[#entities+1] = Player(world, spawnX+16, spawnY - 2*B, entities)

    entities[#entities+1] = Block(world, "freq0", W-2*B, H-B2-2*B)

    entities[#entities+1] = Block(world, "freq0", W-4*B, H-B2-4*B)
    entities[#entities+1] = Block(world, "freq0", W-4*B-b, H-B2-4*B)
    entities[#entities+1] = Block(world, "freq0", W-4*B-2*b, H-B2-4*B)

    entities[#entities+1] = Block(world, "freq0", W-B-b, B+b)
    entities[#entities+1] = Block(world, "freq0", W-B, B+b)
    entities[#entities+1] = Block(world, "freq0", W-B, B)
    entities[#entities+1] = Block(world, "freq0", W-B, 0)

    entities[#entities+1] = Flag(Game, W-B-b, b, levelThree)
end

function levelOne(Game)

    local entities = Game.entities
    local world = Game.world

    -- Create a generic entity (dynamic)
    -- entities[#entities+1] = Entity(world, assets.entity, 256 - 32, 256 - 32 - 64, 64, 64)

    -- Level Blocks

       -- stairs
       for y=1,4 do
           for x=1,(5-y) do
               entities[#entities+1] = Block(world, "freq0", W - 1*B - x*b, H-B2-B-(y-1)*b)
           end
       end

       -- column
       for y=1,4 do
           entities[#entities+1] = Block(world, "freq0", W - B, H-B2-B-(y-1)*b)
       end

    -- entities[#entities+1] = Block(world, "freq0", W-4*B, H-B2-B)
    -- entities[#entities+1] = Block(world, "freqA", W-3*B, H-B2-2*B)
    -- entities[#entities+1] = Block(world, "freqB", W-2*B, H-B2-3*B)
    -- entities[#entities+1] = Block(world, "freqC", W-1*B, H-B2-4*B)
    
    -- Flag
    entities[#entities+1] = Flag(Game, W-B, H-B2-3*b-2*B, levelTwo)

    -- Z-order is based on creation. Any objects made after the player will appear in front of her.

    -- Create the player and Entry door
    -- spawn coords rel to bottom of player
    local spawnX = 0
    local spawnY = H-B2
    entities[#entities+1] = Prop(world, assets.smalldoor, spawnX, spawnY - B)
    entities[#entities+1] = Player(world, spawnX+16, spawnY - 2*B, entities)
end

return {start=levelOne}
