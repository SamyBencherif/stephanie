
local assets = require("libraries/cargo/cargo").init("assets")
local windfield = require("libraries/windfield/windfield")
local Ground = require("entities/ground")

function worldInitialize(Game)
    
    Game.renderLayers = {
        transparent=love.graphics.newCanvas(512,512)
    }

    Game.world = windfield.newWorld(0, 0, true)
    Game.entities = {}

    local world = Game.world
    local entities = Game.entities

    -- INITIALIZE AND SET PROPERTIES COMMON TO ALL LEVELS.

    -- Use a single joystick. If none is present, show a message
    local joysticks = love.joystick.getJoysticks()
    if #joysticks < 1 then
        print("If you would like to use a joystick, please plug it in before starting the game.")
    end

    Game.Joystick = joysticks[1]

    -- redef of levels.lua:13
    local W = 512
    local H = 512
    local B = 64
    local B2 = 32
    local WB2 = 16
    local HB2 = 16

    world:setGravity(0, 512)

    -- Definition of collision layers
    world:addCollisionClass('freq0')
    world:addCollisionClass('freqA')
    world:addCollisionClass('freqB', {ignores = {'freqA'}})
    world:addCollisionClass('freqC', {ignores = {'freqA', 'freqB'}})

    -- Create the grass
    entities[#entities+1] = Ground(world, assets.grass, --[[ Restitution ]] .02, --[[ Placement ]] 0, H-B2, WB2, 1)

    -- Create barriers that keep player in the world
    -- Not visible, so it doesn't matter what texture we use
    local rwall = Ground(world, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] W, 0, 1, HB2)
    rwall.body:setFriction(0)
    entities[#entities+1] = rwall

    local lwall = Ground(world, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] -B2, 0, 1, HB2)
    lwall.body:setFriction(0)
    entities[#entities+1] = lwall

    local ceil = Ground(world, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] 0, -B2, WB2, 1)
    ceil.body:setFriction(0)
    entities[#entities+1] = ceil


    -- SET ALL DELEGATES

    love.update = function(dt)

        -- For all entities, handle input
        -- and preform logic code
        for i,ent in pairs(Game.entities) do
            if ent.input then ent:input(Game.Joystick) end
            ent:update(dt)
        end

        -- preform a physics step
        Game.world:update(dt)
    end

    love.gamepadpressed = function(joy, btn)
        for i,ent in pairs(Game.entities) do
            if ent.btnDown then ent:btnDown(btn, nil) end
        end
    end

    love.keypressed = function(key, scan)
        for i,ent in pairs(Game.entities) do
            if ent.btnDown then ent:btnDown(nil, key) end
        end
    end

    love.draw = function()

        -- sky color
        love.graphics.clear(.2, .8, 1, 1)

        -- For all entities, preform rendering code
        for i,ent in pairs(Game.entities) do
            ent:draw(false) -- true uses old collider renderer, always set to false
            if SHOWCOLLIDERS then Game.world:draw(128) end
        end
    end


end

return worldInitialize
