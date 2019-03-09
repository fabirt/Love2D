
require 'MessageInABottle.lua'
require 'background/background.lua'

function love.load()
  love.graphics.setBackgroundColor(255,255,255)
  background = Background:new()
  
  --Initialize the ocean to manage the bottles.
  --It is going to act as a Queue. FIFO
  ocean = Ocean:new()
  
  --Create a timed bottle and add it to the ocean
  ocean:addBottle(TimeBottle:new(nil,"...",nil))
  
  local bottle = StayBottle:new(nil,"What is this?")
  bottle:setX(310)
  bottle:setVolume(0)
  ocean:addBottle(bottle)
  
  local bottle = TimeBottle:new(nil,"Isn't it obvious? It is a message in a bottle.")
  ocean:addBottle(bottle)
  
  local bottle = StayBottle:new(nil,"Wow, I didn't know those existed!")
  bottle:setX(310)
  bottle:setVolume(0)
  ocean:addBottle(bottle)
  
  ocean:addBottle(TimeBottle:new(nil,"Should we open it and read it?"))
  
  local bottle = TimeBottle:new("Open Bottle","Press 'o' to open bottle.")
  bottle:setPosition(155, 100)
  bottle:setExitCallback(forkStory)
  bottle:setButton("o")
  bottle:setTimeout(2)
  ocean:addBottle(bottle)
  --ocean:addBottle(ChoiceBottle:new())
end

function forkStory(result)
  if result == 0 then
    ocean:addBottle(TimeBottle:new(nil,"Yay!"))
  elseif result == 1 then
    ocean:addBottle(TimeBottle:new(nil,"Too slow! I lost interest."))
  end
end

function love.update(dt)
  ocean:update(dt)
  background:update(dt)
end

function love.draw()
  background:draw()
  love.graphics.setColor(0,0,0)
  love.graphics.print(
      'last bottle return was: '..ocean.response..
      ' at '..(math.floor(ocean.responseTime*10)/10)..
      's from '..ocean.responseID,12,12)
  ocean:draw()
end

function love.keypressed(k,u)
  if k=="d" then
    local bottle = TimeBottle:new("PRESSED_D","Timed Box!")
    bottle:setX(math.floor(math.random(400)))
    bottle:setY(math.floor(math.random(150)))
    ocean:addBottle(bottle)
  elseif k=="escape" then
    love.event.push("q")
  end
end

