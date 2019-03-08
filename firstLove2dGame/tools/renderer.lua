local Renderer = {}

local numLayers = 5

function Renderer:load()
	self.renderers = {}
end

function Renderer:addRenderer(obj)
	table.insert(self.renderers,obj)
end

-- rem
function Renderer:removeRenderer(obj)
	for i = #self.renderers,1,-1 do
		if self.renderers[i] == obj then
			table.remove(self.renderers,i)
			return
		end
	end
end

-- end rem

function Renderer:draw(dt)
	for i = 1,#self.renderers do
		local obj = self.renderers[i]
		obj:draw(dt)
	end
end

return Renderer