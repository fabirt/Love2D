-- Tools
require("tools/collisions")

-- Entities
Player = require("entities/player")
Bullet = require("entities/bullet")
Enemy = require("entities/enemy")

width = love.graphics.getWidth()
height = love.graphics.getHeight()

-- Timers
-- We declare these here so we don't have to edit them multiple places
canShoot = true
canShootTimerMax = 0.3
canShootTimer = canShootTimerMax

-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated

--More timers
createEnemyTimerMax = 0.8
createEnemyTimer = createEnemyTimerMax

-- More images
enemyImg = nil -- Like other images we'll pull this in during out love.load function

-- More storage
enemies = {} -- array of current enemies on screen

isAlive = true
score = 0

local GameScreen = {}

function GameScreen:new()
    local gameScreen = require("components/entity"):new(10, 10, 10, 10, 10, nil, nil, "game")
    
    function gameScreen:load(arg)
        renderer:addRenderer(self)
        gameLoop:addLoop(self)

        gunSound = love.audio.newSource("assets/sounds/gun-sound.wav", "static")
        musicTrack = love.audio.newSource("assets/sounds/track1.mp3", "static")
        enemyImg = love.graphics.newImage("assets/enemy.png")
    
        player = Player:new(200, 610)
    
        musicTrack:setLooping(true)
        musicTrack:play()
    end
    
    function gameScreen:tick(dt)
        -- I always start with an easy way to exit the game
        if love.keyboard.isDown("escape") then
            love.event.push("quit")
        end

        player:tick(dt)
    
        canShootTimer = canShootTimer - (1 * dt)
        if canShootTimer < 0 then
            canShoot = true
        end
        if love.keyboard.isDown("space") and canShoot and isAlive then
            -- Create some bullets
            bullet = Bullet:new(player.pos.x + player:getX(), player:getY())
            table.insert(bullets, bullet)
            canShoot = false
            canShootTimer = canShootTimerMax
            gunSound:play()
        end
        if #bullets > 0 then
            for i, bullet in ipairs(bullets) do
                bullet:tick(dt)
            end
        end
    
        -- Time out enemy creation
        createEnemyTimer = createEnemyTimer - (1 * dt)
        if createEnemyTimer < 0 then
            createEnemyTimer = createEnemyTimerMax
            -- Create an enemy
            randomNumber = math.random(10, love.graphics.getWidth() - enemyImg:getWidth())
            enemy = Enemy:new(randomNumber, -10)
            table.insert(enemies, enemy)
        end
        if #enemies > 0 then
            for i, enemy in ipairs(enemies) do
                enemy:tick(dt)
            end
        end
    
        -- run our collision detection
        -- Since there will be fewer enemies on screen than bullets we'll loop them first
        -- Also, we need to see if the enemies hit our player
        for i, enemy in ipairs(enemies) do
            for j, bullet in ipairs(bullets) do
                if
                    CheckCollision(
                        enemy.pos.x,
                        enemy.pos.y,
                        enemy.img:getWidth(),
                        enemy.img:getHeight(),
                        bullet.pos.x,
                        bullet.pos.y,
                        bullet.img:getWidth(),
                        bullet.img:getHeight()
                    )
                 then
                    table.remove(bullets, j)
                    table.remove(enemies, i)
                    score = score + 1
                end
            end
    
            if
                CheckCollision(
                    enemy.pos.x,
                    enemy.pos.y,
                    enemy.img:getWidth(),
                    enemy.img:getHeight(),
                    player.pos.x,
                    player.pos.y,
                    player.img:getWidth(),
                    player.img:getHeight()
                ) and isAlive
             then
                table.remove(enemies, i)
                isAlive = false
            end
        end
    
        if not isAlive and love.keyboard.isDown("r") then
            -- remove all our bullets and enemies from screen
            bullets = {}
            enemies = {}
    
            -- reset timers
            canShootTimer = canShootTimerMax
            createEnemyTimer = createEnemyTimerMax
    
            -- move player back to default position
            player.pos.x = 200
            player.pos.y = 610
            player:load()
    
            -- reset our game state
            score = 0
            isAlive = true
        end
    
        
    end
    
    function gameScreen:draw(dt)
        love.graphics.print("SCORE: " .. tostring(score), 400, 10)
        if not isAlive then
            love.graphics.print("Press 'R' to restart", width / 2 - 50, height / 2 - 10)
        end
        if isAlive then
            player:draw(dt)
        end

        if #bullets > 0 then
            for i, bullet in ipairs(bullets) do
                bullet:draw(dt)
            end
        end
        
        if #enemies > 0 then
            for i, enemy in ipairs(enemies) do
                enemy:draw(dt)
            end
        end

    end

    return gameScreen
end

return GameScreen