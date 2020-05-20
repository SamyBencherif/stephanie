--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Entity = require("entities/entity")

local Block = Entity:extend()

function Block:new(Game, class, x, y)

    -- class specifies the core game mechanic, collision layers
    -- (referred to in-game as resontant frequencies)
    -- there are three resonant frequencies "freqA", "freqB", and "freqC"
    -- there is also "freq0" which collides with everything
    local world = Game.world

    local tex

    if class == "freqA" then
        tex = assets.smallblockred
    elseif class == "freqB" then
        tex = assets.smallblockblue
    elseif class == "freqC" then
        tex = assets.smallblockyellow
    else
        tex = assets.smallblock
    end

    Entity.new(self, Game, tex, x, y, true)
    self.body:setRestitution(.015)
    self.body:setCollisionClass(class)

    -- keep track of this for setOpaque and other potential functions
    self.class = class

end

function Block:setOpaque(o)
    self.transparent = not o
end

return Block
