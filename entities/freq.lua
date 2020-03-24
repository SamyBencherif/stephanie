--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

--
-- DESIGN CHANGE
--

-- Actually, I'm going to put this feature in player.lua


local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Freq = Object:extend()

function Freq:new(world)

    self.world = world

    -- FREQUENCIES
    -- 0 : Black
    -- A : Red
    -- B : Blue
    -- C : Yellow
    self.frequency = "A"

    -- When player is at Freq_0 she collides with everything
    -- When she is at Freq_A she collides with other objects at Freq_A and objects at Freq_0
    -- Objects at Freq_0 are always collided with, thus...
    -- When she is at Freq_B she collides with other objects at Freq_B and objects at Freq_0
    -- When she is at Freq_C she collides with other objects at Freq_C and objects at Freq_0

    -- Using this variable to keep track of time
    self.t = 0

end

function Freq:input(Joystick)
    
    -- Freq rot forward
    if (Joystick and Joystick:isGamepadDown("b")) or love.keyboard.isDown("x") then
    end

    -- Freq rot backward
    if (Joystick and Joystick:isGamepadDown("y")) or love.keyboard.isDown("x") then
    end
end

function Freq:update(dt)
    self.t = self.t + dt
end

function Freq:draw(showColliders)
end

return Freq
