--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

local Object = require("libraries/classic/classic")
local Player = require("entities/player")
local Prop = require("entities/prop")
local assets = require("libraries/cargo/cargo").init("assets")

local GameTools = require("GameTools")

local Button = Prop:extend()

function Button:new(Game, x, y, targetLevel)

    -- Holding on to this information for rendering later
    self.sprite = assets.smallflag

    -- The flag looks good with this hardcoded offset
    self.x = x + 19
    self.y = y
    self.w = self.sprite:getWidth()
    self.h = self.sprite:getHeight()

    -- The flag object does use the world
    -- to figure out when the player reaches
    -- the end of the level
    self.Game = Game

    -- for transition to next level
    self.targetLevel = targetLevel

    -- Using this variable to keep track of time
    self.t = 0
end

function Button:update(dt)
    self.t = self.t + dt
    
    -- -- load self.targetLevel
    -- while (#self.Game.entities ~= 0) do
    --     table.remove(self.Game.entities)
    -- end
    -- worldInitialize(self.Game)
    -- self.targetLevel(self.Game)
    -- return

end

function Button:draw(showColliders)
    love.graphics.rectangle("fill", self.x, self.y, 64, 16 )
end

return Button
