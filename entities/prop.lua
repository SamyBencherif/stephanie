--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Prop = Object:extend()

function Prop:new(world, sprite, x, y)

    -- This kind of object is non-solid. Good for decorations

    -- Holding on to this information for rendering later
    self.sprite = sprite
    self.x = x
    self.y = y
    self.w = sprite:getWidth()
    self.h = sprite:getHeight()

    -- Still going to hold on to an instance of the world
    -- in case we use a subclass as a trigger
    self.world = world

    -- Using this variable to keep track of time
    self.t = 0
end

function Prop:update(dt)
    self.t = self.t + dt
    
    -- Use this for the flag
    -- world:queryRectangleArea(100, 100, 50, 50, {'Enemy', 'NPC'})

end

function Prop:draw(showColliders)
    -- love physics reports rectangle center, and we draw from top left position
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Prop
