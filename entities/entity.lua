--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Entity = Object:extend()

function Entity:new(world, sprite, x, y, w, h, isStatic, notSolid)

    -- TODO startSleeping option to prevent unwanted bouncing and blurring

    -- Holding on to this information for rendering later
    self.sprite = sprite
    self.w = w
    self.h = h

    -- Using this variable to keep track of time
    self.t = 0

    -- 64x64 matches the entity texture
    self.body = world:newRectangleCollider(x, y, w, h)
    self.body:setRestitution(0.4)

    -- Optionally the object can be fixed in place, like a floor or wall
    if isStatic then
        self.body:setType('static')
    end

    -- Object can be jumped from
    if not notSolid then
        self.body:setCollisionClass('solid')
    end

    -- Objects never rotate in this game
    self.body:setFixedRotation(true)

    -- Maintains a reference from a collider to the object
    self.body:setObject(self)
end

function Entity:update(dt)
    self.t = self.t + dt
end

function Entity:draw(showColliders)

    -- love physics reports rectangle center, and we draw from top left position
    love.graphics.draw(self.sprite, self.body:getX() - self.w/2, self.body:getY() - self.h/2)

    if showColliders then
        love.graphics.rectangle( 'line', 
        self.body:getX() - self.w/2, 
        self.body:getY() - self.h/2, 
        self.w, 
        self.h)
    end

end

return Entity
