function love.load()

	font = love.graphics.newFont("PixelFont.TTF",54)
	love.graphics.setFont(font)
	love.graphics.setDefaultFilter("nearest","nearest")
	res = love.graphics.newImage("Resource.png")
	brickSide = love.graphics.newQuad(256,0,8,16,res:getDimensions())
	metalSide = love.graphics.newQuad(256,16,8,16,res:getDimensions())
end

Rooms = class("Rooms")

function Rooms:init()
	self.rooms = {}--格式：{模式（1:5v5，2：夺旗，3：单人），人数Max，当前人数}
	self.select = 1
end

function Rooms:draw()
	for i=0,21 do
		love.graphics.draw(res, brickSide, i*60+60,0,math.pi/2,60/16)
		love.graphics.draw(res, brickSide, i*60+60,30,math.pi/2,60/16)
	end
	for i=0,10 do
		love.graphics.draw(res, brickSide,0,i*60+60,0,60/16)
		love.graphics.draw(res, brickSide,1250,i*60+60,0,60/16)
	end
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill",340,15,600,30)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("Room List", 550,17.5,0,0.5)
	love.graphics.print("Press 'C' to create a room.\nPress 'R' to refresh.",35,65,0,0.5)
	if #self.rooms == 0 then
		love.graphics.print("No Room",460,320)
	else
		for k,v in pairs(self.rooms) do
			if k-self.select+2 < 5 and k-self.select+2 > 1 then
				love.graphics.setColor(255, 255, 255, 255)
				local mode
				if v[1] == 1 then
					mode = "Team Battle"
				elseif v[1] == 2 then
					mode = "Flag Capture"
				elseif v[1] == 3 then
					mode = "Single Battle"
				end
				love.graphics.rectangle("line", 60+(k-self.select)*400, 140, 350, 550)
				love.graphics.print("Room "..k, 70+(k-self.select)*400, 150,0,0.6)
				love.graphics.print("Mode:\n"..mode, 70+(k-self.select)*400, 200,0,0.6)
				love.graphics.print("Players:\n"..v[3].."/"..v[2], 70+(k-self.select)*400, 300,0,0.6)
			end
			if k-self.select+2 == 2 then
				love.graphics.setColor(255, 255, 255, 100)
				love.graphics.rectangle("fill", 60+(k-self.select)*400, 140, 350, 550)
			end
		end
	end
	love.graphics.setColor(255, 255, 255, 255)
end

function Rooms:keypressed(key)
	if key == "right" and self.select<#self.rooms then
		self.select = self.select + 1
	elseif key == "left" and self.select>1 then
		self.select = self.select - 1
	end
end
