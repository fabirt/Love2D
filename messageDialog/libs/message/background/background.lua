
Background = class('Background')

function Background:initialize()
  super.initialize(self)
  math.randomseed(os.time())
  math.random()
  math.random()
  
  self.time = 0
  
  self.logo = {}
  self.logo.y = 0
  self.logo.r = 0
  self.logo.img = love.graphics.newImage('logo/message-in-a-bottle.png')
  self.logo.img:setFilter('linear','nearest')
  
  self.cloudsF = {}
  self.cloudsB = {}
  self.cloud = love.graphics.newImage('background/cloud.png')
  --Initialize clouds
  for i=0, 7, 1 do
    local cloud = {x = math.random(696)-64 ,y = math.random(90)-30 ,v = math.random(5)+10}
    table.insert(self.cloudsB, cloud)
  end
  for i=0, 5, 1 do
    local cloud = {x = math.random(696)-64 ,y = math.random(90)-30 ,v = math.random(5)+10}
    table.insert(self.cloudsF, cloud)
  end
  
  self.love = love.graphics.newImage('background/love.png')
  
  self.waterh = 150
end

function Background:update(dt)
  self.time = self.time + dt
  self.waterh = 150 + math.sin(self.time)*3
  self.logo.y = self.waterh-140 + math.sin(self.time*3.153)*2
  self.logo.r = math.sin(self.time*2.684)*0.05
  --update Clouds
  for _,cloud in ipairs(self.cloudsB) do
    if cloud.x > 630 then
      cloud.x = -128
      cloud.v = math.random(5)*10
      cloud.y = math.random(90)-30
    end
    cloud.x = cloud.x + cloud.v*dt
  end
  for _,cloud in ipairs(self.cloudsF) do
    if cloud.x > 630 then
      cloud.x = -128
      cloud.v = math.random(5)+10
      cloud.y = math.random(90)-30
    end
    cloud.x = cloud.x + cloud.v*dt
  end
end

function Background:draw()
  local logo = self.logo
  local h = self.waterh
  love.graphics.setColor(142,214,255)
  love.graphics.rectangle("fill",0,0,630,300)
  love.graphics.setColor(255,255,255,150)
  for _,cloud in ipairs(self.cloudsB) do
    love.graphics.draw(self.cloud,cloud.x,cloud.y, 0, 0.75)
  end
  love.graphics.setColor(255,255,255)
  love.graphics.draw(self.love, 365,-15)
  love.graphics.setColor(255,255,255,150)
  for _,cloud in ipairs(self.cloudsF) do
    love.graphics.draw(self.cloud,cloud.x,cloud.y, 0, 0.75)
  end
  
  love.graphics.setColor(255,255,255,240)
  love.graphics.draw(logo.img,300,logo.y+h,logo.r,8,8,16,16)
  love.graphics.setColor(0,0,255,160)
  love.graphics.rectangle("fill",0,h,630,300)
end
