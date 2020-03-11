
-- Some internal configuration

SHOWCOLLIDERS = true

-- Entity imports
local Player = require "entities/player"
local Entity = require "entities/entity"
local Ground = require "entities/ground"

local assets = require("libraries/cargo/cargo").init("assets")

-- World Physics
local windfield = require "libraries/windfield/windfield"

-- Game-wide state
local Joystick
local entities = {}
local world

function starterScene()
    -- Create the player
    entities[#entities+1] = Player(world, 0, 256 - 32 - 128)

    -- Create the grass
    entities[#entities+1] = Ground(world, assets.grass, --[[ Restitution ]] .02, --[[ Placement ]] 0, 512-32, 16, 1)

    -- Create barriers that keep player in the world
    local rwall = Ground(world, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] 512, 0, 1, 16)
    rwall.body:setFriction(0)
    entities[#entities+1] = rwall

    local lwall = Ground(world, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] -32, 0, 1, 16)
    lwall.body:setFriction(0)
    entities[#entities+1] = lwall

    local ceil = Ground(world, assets.grass, --[[ Restitution ]] 0, --[[ Placement ]] 0, -32, 16, 1)
    ceil.body:setFriction(0)
    entities[#entities+1] = ceil

    -- Create a generic entity (dynamic)
    entities[#entities+1] = Entity(world, assets.entity, 256 - 32, 256 - 32 - 64, 64, 64)

end

function love.load()

    world = windfield.newWorld(0, 0, true)
    world:setGravity(0, 512)

    -- Definition of collision layers
    world:addCollisionClass('solid')

    if SHOWCOLLIDERS then 
        world:setQueryDebugDrawing(true)
    end

    -- Load a global scene (I don't have scene mgmt yet)
    starterScene()

    -- Use a single joystick. If none is present, crash the program
    local joysticks = love.joystick.getJoysticks()
    if #joysticks < 1 then
        print("If you would like to use a joystick, please plug it in before starting the game.")
    end

    Joystick = joysticks[1]
end

function love.update(dt)

    -- For all entities, handle input
    -- and preform logic code
    for i,ent in pairs(entities) do
        if ent.input then ent:input(Joystick) end
        ent:update(dt)
    end

    -- preform a physics step
    world:update(dt)
end

function love.draw()

    -- sky color
    love.graphics.clear(.2, .8, 1, 1)

    -- For all entities, preform rendering code
    for i,ent in pairs(entities) do
        ent:draw(false) -- true uses old collider renderer, always set to false
        if SHOWCOLLIDERS then world:draw(128) end
    end
end
