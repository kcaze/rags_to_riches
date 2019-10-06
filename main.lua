local game = require("sections/game")

local currentSection = nil

function switchSection(newSection)
  newSection.load()
  currentSection = newSection
end

function love.load()
  love.window.setMode(800,600,{highdpi = true})
  switchSection(game)
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
