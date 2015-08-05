Font = Object:new()

function Font:init()

	self.img = love.graphics.newImage("media/font.png")
	self.img:setFilter("nearest", "nearest")
	self.scale = 2

	self.quads = {}

	local w = self.img:getWidth()
	local h = self.img:getHeight()
	local cw = w / 8
	local ch = h / 16

	for i = 0, 127 do
		local c = string.char(i)
		local x = (i % 8) * cw
		local y = math.floor(i / 8) * ch
		self.quads[c] = love.graphics.newQuad(x, y, cw, ch, w, h)
	end

	self.char_width = cw
	self.char_height = ch

end


function Font:printCentered(text, x, y, s)
	local dx = (s or self.scale) * self.char_width
	self:print(text, x - #text * dx * 0.5, y, s)
end

function Font:print(text, x, y, s)
	s = s or self.scale
	local dx = s * self.char_width
	local img = self.img
	local quads = self.quads

	love.graphics.push()
	for c in text:gmatch(".") do
		local q = quads[c]
		if q then
			love.graphics.draw(img, q, x, y, 0, s)
		end
		love.graphics.translate(dx, 0)
	end
	love.graphics.pop()
end
