--  title: entity.lua
-- author: Samy Bencherif
--   desc: Parent class of all game entities

Object = require "libraries/classic/classic"
assets = require("libraries/cargo/cargo").init("assets")

Entity = Object:extend()

function Entity:new()
    self.t = 0
end

function Entity:update(dt)
    self.t = self.t + dt
end

function Entity:draw()
    love.graphics.draw(
        assets.entity, 
        --[[ x-pos ]] 100, 
        --[[ y-pos ]]  100,
        self.t * 6
    )
end
