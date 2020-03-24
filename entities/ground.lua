--  title: ground.lua
-- author: Samy Bencherif
--   desc: Parent class of tiling static game objects

local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Ground = Object:extend()

-- TODO: I've been hardcoding tex dimensions but :getWidth/Height can be used instead

-- blockWidth/Height count how many times to tile the texture
function Ground:new(world, sprite, restitution, x, y, blockWidth, blockHeight)

    -- Ground(world, assets.grass, .2, 100, 100, 3, 1)
    -- creates rectangle (100, 100, 3*64, 64)  with restitution .2

    self.sprite = sprite

    -- All ground textures are 64x64
    self.w = 32 * blockWidth
    self.h = 32 * blockHeight

    -- TODO: support texture endcaps

    -- 64x64 matches the entity texture
    self.body = world:newRectangleCollider(x, y, self.w, self.h)
    self.body:setRestitution(restitution)

    -- The object is fixed in place
    self.body:setType('static')

    -- Objects never rotate in this game
    self.body:setFixedRotation(true)

    -- Maintains a reference from a collider to the object
    self.body:setObject(self)
end

function Ground:update(dt)
end

function Ground:draw(showColliders)

    -- love physics reports rectangle center, and we draw from top left position

    for tx=0,self.w-1,32 do
        for ty=0,self.h-1,32 do
            love.graphics.draw(self.sprite, self.body:getX() - self.w/2 + tx, self.body:getY() - self.h/2 + ty)
        end
    end

    if showColliders then
        love.graphics.rectangle('line', 
        self.body:getX() - self.w/2, 
        self.body:getY() - self.h/2, 
        self.w, 
        self.h)
    end

end

return Ground
