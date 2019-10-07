local game = require("sections/game")
local mainMenu = require("sections/mainMenu")

local currentSection = nil
local sections = {
  game = game,
  mainMenu = mainMenu
}

local screenTransform = {
  scale = 1, dx = 0, dy = 0
}

function switchSection(newSection, data)
  currentSection = sections[newSection]
  currentSection.switchSection = switchSection
  currentSection.load(data)
end


function love.load()
  love.window.setMode(800*screenTransform.scale,
                      600*screenTransform.scale,
                      {highdpi = true, resizable = true})
  love.filesystem.setIdentity('beggars-can-be-choosers')
  love.window.setTitle("Beggars Can Be Choosers")
  switchSection('mainMenu')
end

function love.draw()
  love.graphics.translate(screenTransform.dx, screenTransform.dy)
  love.graphics.scale(screenTransform.scale)
  currentSection.draw(screenTransform)
end

function love.update(dt)
  currentSection.update(dt, screenTransform)
end

function love.mousepressed(x,y,button)
  t = screenTransform
  currentSection.mousepressed(
    (x - t.dx)/t.scale,
    (y - t.dy)/t.scale,
    button)
end

function love.mousereleased(x,y,button)
  t = screenTransform
  currentSection.mousereleased(
    (x - t.dx)/t.scale,
    (y - t.dy)/t.scale,
    button)
end

function love.conf(t)
  t.console = true
end

function love.resize(w, h)
  rx = w / 800
  ry = h / 600
  r = math.min(rx, ry)
  screenTransform.scale = r
  screenTransform.dx = math.floor((rx - r) * 800 / 2)
  screenTransform.dy = math.floor((ry - r) * 600 / 2)
end
