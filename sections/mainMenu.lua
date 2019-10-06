local state = require("../state")
local music = require("../music")
local event = require("../event")
local coin = require("../coin")
local image = require("../image")
local mainMenu = {}

mainMenu.load = function()
  love.graphics.setNewFont("font.ttf", 72):setLineHeight(0.75)
end

mainMenuFloat = 0

mainMenu.draw = function ()
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(image.mainMenuBg, image.mainMenuBgQuad, 0, 0)
  love.graphics.setColor(1,1,1,1)
  love.graphics.setNewFont("font.ttf", 72):setLineHeight(0.75)
  love.graphics.printf('Beggars Can Be Choosers', 0, 40, 800, 'center')

  love.graphics.setNewFont("font.ttf", 36):setLineHeight(0.75)
  love.graphics.printf('New Game', 0, 240, 800, 'center')
end

mainMenu.update = function (dt)
  --mainMenuFloat = math.fmod(mainMenuFloat + 2*dt, 2*math.pi)
end

mainMenu.mousepressed = function (x,y,button)
end

mainMenu.mousereleased = function (x,y,button)
end

return mainMenu