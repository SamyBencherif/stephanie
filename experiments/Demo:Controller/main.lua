
-- Input = require 'libraries/boipushy/Input'
-- boipushy has some bugs, it seems

-- So I will use Love native
-- https://love2d.org/wiki/love.joystick.getJoysticks
-- https://love2d.org/wiki/Joystick:isGamepadDown
-- https://love2d.org/wiki/GamepadButton

local BLUE = { .3, .2, .8, 1 }
local BLACK = { .03, .03, .03, 1 }

local trk_keys = {}

function input_log(btn, value, index)
    love.graphics.print( { BLUE, btn.." ", BLACK, value } , 10, 15 * index )
end

function q_bind(x)
    trk_keys[#trk_keys+1] = x
end

function love.load()
    
    q_bind("a")
    q_bind("b")
    q_bind("x")
    q_bind("y")
    q_bind("back")
    q_bind("guide")
    q_bind("start")
    q_bind("leftstick")
    q_bind("rightstick")
    q_bind("leftshoulder")
    q_bind("rightshoulder")
    q_bind("dpup")
    q_bind("dpdown")
    q_bind("dpleft")
    q_bind("dpright")

    Joystick = love.joystick.getJoysticks( )[1]

    if #love.joystick.getJoysticks( ) < 1 then
        print("No joystick.")
    end
end

love.update = function(dt)
end

love.draw = function()
   love.graphics.clear(1,1,1,1)

   for i,v in pairs(trk_keys) do
       if Joystick:isGamepadDown( v ) then
           input_log(v, "PRESSED", i) 
       else
           input_log(v, "", i) 
       end
   end
end
