local game = require("sections/game")
local mainMenu = require("sections/mainMenu")

local currentSection = nil
local sections = {
  game = game,
  mainMenu = mainMenu
}

local gameScale = 1

function switchSection(newSection, data)
  currentSection = sections[newSection]
  currentSection.switchSection = switchSection
  currentSection.load(data)
end


function love.load()
  love.window.setMode(800*gameScale,600*gameScale,{highdpi = true})
  love.filesystem.setIdentity('beggars-can-be-choosers')
  switchSection('mainMenu')
end

function love.draw()
  love.graphics.scale(gameScale)
  currentSection.draw(gameScale)
end

function love.update(dt)
  currentSection.update(dt, gameScale)
end

function love.mousepressed(x,y,button)
  currentSection.mousepressed(x/gameScale,y/gameScale,button)
end

function love.mousereleased(x,y,button)
  currentSection.mousereleased(x/gameScale,y/gameScale,button)
end

function love.conf(t)
  t.console = true
end
