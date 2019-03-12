-- Import our libraries.
local Gamestate = require "libs.hump.gamestate"
local Class = require "libs.hump.class"
require "libs.paddy.paddy"

-- Grab our base class
local LevelBase = require "gamestates.LevelBase"

-- Import the Entities we will build.
local Player = require "entities.player"
local camera = require "libs.camera"

-- Declare a couple immportant variables
player = nil

local gameLevel1 =
    Class {
    __includes = LevelBase
}

function gameLevel1:init()
    LevelBase.init(self, "assets/levels/level_1.lua")
    musicTrack = love.audio.newSource("assets/sounds/spooky-island.mp3", "static")
    musicTrack:setLooping(true)
    musicTrack:play()
end

function gameLevel1:enter()
    player = Player(self.world, 64, 64)
    LevelBase.Entities:add(player)
end

function gameLevel1:update(dt)
    self.map:update(dt) -- remember, we inherited map from LevelBase
    LevelBase.Entities:update(dt) -- this executes the update function for each individual Entity
    self:restart()

    LevelBase.positionCamera(self, player, camera)
end

function gameLevel1:draw()
    -- Attach the camera before drawing the entities
    camera:set()
    
    self.map:draw(-camera.x, -camera.y) -- Remember that we inherited map from LevelBase
    LevelBase.Entities:draw() -- this executes the draw function for each individual Entity
        
    camera:unset()
    -- Be sure to detach after running to avoid weirdness
    paddy.draw()
end

function gameLevel1:restart()
    -- if player.y > love.graphics.getHeight() then
    --     player:reset(32, 64)
    -- end
end

-- All levels will have a pause menu
function gameLevel1:keypressed(key)
    LevelBase:keypressed(key)
end

return gameLevel1
