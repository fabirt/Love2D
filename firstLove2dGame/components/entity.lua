local rect = require "components/rect"
local vec2 = require "components/vec2"

local Entity = {}

function Entity:new(x, y, w, h, speed, img, quad, id)
	local entity = rect:new(x,y,w,h)

	entity.id  = id or "Entity"

	entity.pos  = vec2:new(x,y)
	entity.size = vec2:new(w,h)

	entity.vel = vec2:new(0,0)
	entity.dir = vec2:new(0,0)
	
	entity.speed = speed
	entity.img = img

	entity.remove = false

	function entity:load()end
	function entity:tick(dt)end
	function entity:draw(dt)end

	return entity
end

return Entity