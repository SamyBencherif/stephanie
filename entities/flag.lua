--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

local Object = require("libraries/classic/classic")
local Player = require("entities/player")
local Prop = require("entities/prop")
local assets = require("libraries/cargo/cargo").init("assets")

local GameTools = require("GameTools")

local Flag = Prop:extend()

function Flag:new(Game, x, y, targetLevel)

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

function Flag:update(dt)
    self.t = self.t + dt
    
    -- Use this for the flag
    local q = self.Game.world:queryRectangleArea(self.x, self.y, self.w, self.h)
    for i,body in pairs(q) do
        local ent = body:getObject()
        if ent:is(Player) then
            GameTools.destroyWorld(self.Game)

            if (self.targetLevel) then
                GameTools.initWorld(self.Game)
                self.targetLevel(self.Game)
            end

            love.graphics.setCanvas(self.Game.renderLayers.transparent)
            love.graphics.clear(0,0,0,0)
            love.graphics.setCanvas()
            love.graphics.clear(0,0,0,1)

            return
        end
    end

end

function Flag:draw(showColliders)
    -- love physics reports rectangle center, and we draw from top left position
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Flag
