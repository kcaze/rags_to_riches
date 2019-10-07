local state = require("../state")
local music = require("../music")
local event = require("../event")
local coin = require("../coin")
local image = require("../image")
local font = require("../font")
local savefile = require("../savefile")
local mainMenu = {}

local track1 = love.audio.newSource("music/bgm.mp3", "stream") 
track1:setLooping(true)

mainMenu.load = function()
  track1:play()
end

local bg_offset_w = 0
local bg_offset_h = 0
local newGameFloat = 0
local newGameHover = false
local continueFloat = 0
local continueHover = false
local musicOn = true
local musicHover = false

mainMenu.draw = function ()
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(image.mainMenuBg, image.mainMenuBgQuad, 0, 0)
  love.graphics.setColor(1,1,1,1)
  font.setFont(72)
  love.graphics.printf('Beggars Can Be Choosers', 0, 40, 800, 'center')

  font.setFont(36)
  if newGameHover then
    love.graphics.setColor(1,1,1,1)
  else
    love.graphics.setColor(0.5,0.5,0.5,1)
  end
  love.graphics.printf('New Game', 0, 240+math.sin(newGameFloat)*5, 800, 'center')

  if continueHover then
    love.graphics.setColor(1,1,1,1)
  else
    love.graphics.setColor(0.5,0.5,0.5,1)
  end
  love.graphics.printf('Continue', 0, 320+math.sin(continueFloat)*5, 800, 'center')

  love.graphics.setColor(0.5,0.5,0.5,1)
  font.setFont(16)
  love.graphics.printf('Ludum Dare 45 entry by Ena Hariyoshi, Herman Chau, and Pierre Karashchuk', -6, 575, 800, 'right')

  if musicHover then
    love.graphics.setColor(1,1,1,1)
  else
    love.graphics.setColor(0.5,0.5,0.5,1)
  end
  love.graphics.draw(musicOn and image.musicOn or image.musicOff, 0, 570, 0, 0.3, 0.3)
end

mainMenu.update = function (dt, transform)
  local mx = (love.mouse.getX() - transform.dx) / transform.scale
  local my = (love.mouse.getY() - transform.dy) / transform.scale

  if mx >= (800-150)/2 and mx <= (800+150)/2 and my >= 240 and my <= 240+36+20 then
    newGameFloat = math.fmod(newGameFloat + 8*dt, 2*math.pi)
    newGameHover = true
  else 
    if math.fmod(newGameFloat, math.pi) > 0.2 then
      newGameFloat = math.fmod(newGameFloat + 10*dt, 2*math.pi)
    end
    newGameHover = false
  end
  
  if mx >= (800-150)/2 and mx <= (800+150)/2 and my >= 320 and my <= 320+36+20 then
    if love.filesystem.getInfo(savefile.SAVE_FILE_NAME) then
      continueFloat = math.fmod(continueFloat + 8*dt, 2*math.pi)
      continueHover = true
    end
  else 
    if math.fmod(continueFloat, math.pi) > 0.2 then
      continueFloat = math.fmod(continueFloat + 10*dt, 2*math.pi)
    end
    continueHover = false
  end

  if mx >= 0 and mx <= 30 and my >= 570 and my <= 600 then
    musicHover = true
  else
    musicHover = false
  end

  bg_offset_w = (bg_offset_w - 4*dt)%image.mainMenuBg:getWidth()
  bg_offset_h = (bg_offset_h + 4*dt)%image.mainMenuBg:getHeight()
  image.mainMenuBgQuad:setViewport(bg_offset_w,bg_offset_h,800,600,image.mainMenuBg:getWidth(),image.mainMenuBg:getHeight())
end

mainMenu.mousepressed = function (x,y,button)
  if newGameHover then
    mainMenu.switchSection('game', false)
  end
  if continueHover then
    mainMenu.switchSection('game', true)
  end
  if musicHover then
    if musicOn then
      musicOn = false
      love.audio.setVolume(0.0)
    else
      musicOn = true
      love.audio.setVolume(1.0)
    end
  end
end

mainMenu.mousereleased = function (x,y,button)
end

return mainMenu
