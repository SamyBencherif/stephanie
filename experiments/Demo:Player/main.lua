
local Player = require "entities/player"
local Entity = require "entities/entity"

local Game = {}
local GameTools = require("./GameTools")

love.load = function()
    GameTools.initWorld(Game)

    -- Create only the player
    Game.entities[#Game.entities+1] = Player(Game, 0, 0, Game.entities)
end

love.update = function(dt)
end

love.draw = function()
end
