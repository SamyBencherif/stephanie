
-- Contains basic scene mgmt tools

local assets = require("libraries/cargo/cargo").init("assets")
local windfield = require("libraries/windfield/windfield")
local Ground = require("entities/ground")

function initWorld(Game, menuMode)

    -- Render Layers are used to make multiple textures transparent at once
    -- (without overlaps)
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
    if not menuMode then
        entities[#entities+1] = Ground(Game, assets.grass, --[[ Restitution ]] .02, --[[ Placement ]] 0, H-B2, WB2, 1)
    else
        -- Even if it's a menu, we'll create the world boundaries
        -- but this time we'll lower the grass so it's not visible
        entities[#entities+1] = Ground(Game, assets.grass, --[[ Restitution ]] .02, --[[ Placement ]] 0, H, WB2, 1)
    end

    -- Create barriers that keeps player in world
    -- Not visible, so it doesn't matter what texture we use
    local rwall = Ground(Game, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] W, 0, 1, HB2)
    rwall.body:setFriction(0)
    entities[#entities+1] = rwall

    local lwall = Ground(Game, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] -B2, 0, 1, HB2)
    lwall.body:setFriction(0)
    entities[#entities+1] = lwall

    local ceil = Ground(Game, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] 0, -B2, WB2, 1)
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

        Game.time = (Game.time or 0) + dt

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

        love.graphics.setCanvas(Game.renderLayers.transparent)
        -- Alpha is premultiplied so two clears are required.
        -- (1) To actually clear all pixel RGB values
        love.graphics.clear(0,0,0,1)
        -- (2) To set all alpha values to 0
        love.graphics.clear(0,0,0,0)
        -- ^^^ That took forever for me to figure out
        love.graphics.setCanvas()

        -- For all entities, preform rendering code
        for i,ent in pairs(Game.entities) do
            ent:draw()
            if SHOWCOLLIDERS then Game.world:draw(128) end
        end

        -- Render transparency layer

        -- Canvases are premultiplied, draw as such
        love.graphics.setBlendMode("alpha", "premultiplied")
        love.graphics.setColor( 1,1,1, .5)
        love.graphics.draw(Game.renderLayers.transparent, 0, 0, 0)
        -- Restore to defaults
        love.graphics.setColor( 1,1,1,1 )
        love.graphics.setBlendMode("alpha", "alphamultiply")

    end


end

function destroyWorld(Game)
    -- remove all entities
    while #Game.entities ~= 0 do
        table.remove(Game.entities)
    end
end

return { 
    initWorld=initWorld;
    destroyWorld=destroyWorld 
}
