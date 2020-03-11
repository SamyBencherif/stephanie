--  title: player.lua
-- author: Samy Bencherif
--   desc: This is the entity the player controls

local Object = require("libraries/classic/classic")
local assets = require("libraries/cargo/cargo").init("assets")

local Entity = require("entities/entity")

local Player = Entity:extend()

function Player:new(world, x, y)
    Entity.new(self, world, assets.player, x, y, 32, 64, --[[ static ]] false, --[[ not solid ]] true)

    -- Make the player less bouncy than the default entity
    self.body:setRestitution(.3)

    -- keep a reference to the world
    self.world = world

    self.walkAcceleration = 60000
    self.walkSpeedMax = 200
end

function Player:input(Joystick)

    -- Shorted labels for convenience
    local walkSpeedCurr, y = self.body:getLinearVelocity()
    local walkAcceleration = self.walkAcceleration
    local walkSpeedMax = self.walkSpeedMax
    local touchingGround = #self.world:queryRectangleArea( self.body:getX() - self.w/2, 
    self.body:getY() + self.h/2 - 5, self.w, 10, {'solid'}) ~= 0
    local influence = 1
    if not touchingGround then influence = 0.15 end

    -- This next value represents how much force to deliver

    -- If the player is already moving to the right fairly 
    -- quickly and they press the right arrow, we don't want so much
    -- force

    local maxWalkRatio = walkSpeedCurr/walkSpeedMax

    -- maxWalkRatio is clamped under 1 because we 
    -- don't want to speed up the player too much, but
    -- we would never want to "apply the brakes" over
    -- a button press that matches the current direction

    if maxWalkRatio > 1 then maxWalkRatio = 1 end

    if (Joystick and Joystick:isGamepadDown("dpright")) or love.keyboard.isDown("right") then 

        -- Apply force to the right that diminishes as we
        -- approach walkSpeedMax
        -- note: This is better than clamping the player speed
        -- because normally Terminal Velocity >> Max Walk Speed
        self.body:applyForce(walkAcceleration * (1 - maxWalkRatio) * influence, 0)
    end

    if (Joystick and Joystick:isGamepadDown("dpleft")) or love.keyboard.isDown("left") then 
        -- Apply force to the left that diminishes as we
        -- approach walkSpeedMax
        -- note: maxWalkRatio is negated because we are facing the negative 
        -- axis now
        self.body:applyForce(walkAcceleration * (-maxWalkRatio - 1) * influence, 0)
    end

    if ((Joystick and Joystick:isGamepadDown("dpup")) or love.keyboard.isDown("up")) and touchingGround then 
        -- Jump Impulse
        self.body:applyLinearImpulse(0, -750)
    end
end

return Player
