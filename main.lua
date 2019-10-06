local game = require("sections/game")
local mainMenu = require("sections/mainMenu")

local currentSection = nil
local sections = {
  game = game,
  mainMenu = mainMenu
}

function switchSection(newSection)
  currentSection = sections[newSection]
  currentSection.switchSection = switchSection
  currentSection.load()
end

function love.load()
  love.window.setMode(800,600,{highdpi = true})
  switchSection('mainMenu')
end

function love.draw()
  currentSection.draw()
end

function love.update(dt)
  currentSection.update(dt)
end

function love.mousepressed(x,y,button)
  currentSection.mousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
  currentSection.mousereleased(x,y,button)
end

function love.conf(t)
  t.console = true
end
