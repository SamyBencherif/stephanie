
local Player = require "entities/player"

local e = Entity()

love.update = function(dt)
    e:update(dt)
end

love.draw = function()
    e:draw()
end
