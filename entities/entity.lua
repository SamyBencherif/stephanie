--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Entity = Object:extend()

function Entity:new(Game, sprite, x, y, isStatic)

    self.Game = Game
    local world = Game.world

    -- notSolid objects still recieve collisions, but the player will not consider
    -- them as solid objects it can jump off of. Right now the only object it makes
    -- sense to label this way is the player itself. Otherwise she would always be
    -- able to jump (even while falling).

    -- If you need to make an object that recieves no collisions make a prop instead

    -- TODO startSleeping option to prevent unwanted bouncing and blurring

    -- Holding on to this information for rendering later
    self.sprite = sprite
    self.w = sprite:getWidth()
    self.h = sprite:getHeight()

    -- Using this variable to keep track of time
    self.t = 0

    -- 64x64 matches the entity texture
    self.body = world:newRectangleCollider(x, y, self.w, self.h)
    self.body:setRestitution(0.4)

    -- Optionally the object can be fixed in place, like a floor or wall
    if isStatic then
        self.body:setType('static')
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
if self.transparent then
        love.graphics.setCanvas(self.Game.renderLayers.transparent)
        love.graphics.draw(self.sprite, self.body:getX() - self.w/2, self.body:getY() - self.h/2, 0)
        love.graphics.setCanvas()
    else
        love.graphics.draw(self.sprite, self.body:getX() - self.w/2, self.body:getY() - self.h/2)
    end

    if showColliders then
        love.graphics.rectangle( 'line', 
        self.body:getX() - self.w/2, 
        self.body:getY() - self.h/2, 
        self.w, 
        self.h)
    end

end

return Entity
