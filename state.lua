require("utils")
local inspect = require('inspect')
local font = require('font')
local coin = require('coin')
local event = require('event')
local image = require('image')
local savefile = require('savefile')

local state = {}
state.initializeState = function(shouldLoad)
  state.hp = 20
  state.coins = 0
  state.items = {}
  state.day = 1
  state.happiness = 0
  state.ratLevel = 0
  state.ratsSold = 0
  state.appleFestival = 0
  state.gameOver = false
  state.newTurn(state, shouldLoad)
end

local bg = 0
bg_offset_w = 0
bg_offset_h = 0

state.update = function (dt)
  bg_offset_w = (bg_offset_w - 3*dt)%image['bg'..bg]:getWidth()
  bg_offset_h = (bg_offset_h + 3*dt)%image['bg'..bg]:getHeight()
  image['bg'..bg..'Quad']:setViewport(bg_offset_w,bg_offset_h,800,600,image['bg'..bg]:getWidth(),image['bg'..bg]:getHeight())
end

state.draw = function (currentTurn)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(image['bg'..bg], image['bg'..bg..'Quad'], 0, 0)
  font.setFont(18)
  love.graphics.print("Day: " .. state.day, 5, 0)
  love.graphics.print("Coins: " .. state.coins, 5, 20)
  love.graphics.print("HP: " .. state.hp, 5, 40)

  local itemCounters = {}
  for i = 1, #state.items do
    if not table.containsKey(itemCounters, state.items[i]) then
      itemCounters[state.items[i]] = 0
    end
    itemCounters[state.items[i]] = itemCounters[state.items[i]] + 1 
  end
 
  font.setFont(16)
  love.graphics.print("Inventory:", 100,2)
  local idx = 0
  for itemObj, itemNum in pairs(itemCounters) do
    idx = idx + 1
    love.graphics.draw(itemObj.image, 120+idx*45, 25,0, 40/200,40/200)
    font.setFont(16)
    love.graphics.printf(itemNum, 120+idx*45,5,40,"right")
  end

  if state.gameOver then
    state.drawGameOver(currentTurn)
    return
  end

  local semiBlack = {0,0,0,0.75}
  local black = {0,0,0,1}
  if state.coins >= 1 then
    if love.mouse.getX() >= 5 and love.mouse.getX() <= 85 and love.mouse.getY() < 600 and love.mouse.getY() >= 575 and state.coins >= 1 then
      love.graphics.setColor({144/255*0.5,105/255*0.5,63/255*0.5,1})
      love.graphics.rectangle('fill', 5, 575, 80, 25, 6, 6, 50)
      love.graphics.setColor(black)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $1', 5, 575, 80, 'center')
    else 
      love.graphics.setColor({144/255,105/255,63/255,1})
      love.graphics.rectangle('fill', 5, 575, 80, 25, 6, 6, 50)
      love.graphics.setColor(semiBlack)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $1', 5, 575, 80, 'center')
    end
  end

  if state.coins >= 5 then
    if love.mouse.getX() >= 5 and love.mouse.getX() <= 85 and love.mouse.getY() < 575 and love.mouse.getY() >= 550 and state.coins >= 5 then
      love.graphics.setColor({140/255*0.5,140/255*0.5,140/255*0.5,1})
      love.graphics.rectangle('fill', 5, 550, 80, 25, 6, 6, 50)
      love.graphics.setColor(black)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $5', 5, 550, 80, 'center')
    else 
      love.graphics.setColor({140/255,140/255,140/255,1})
      love.graphics.rectangle('fill', 5, 550, 80, 25, 6, 6, 50)
      love.graphics.setColor(semiBlack)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $5', 5, 550, 80, 'center')
    end
  end

  if state.coins >= 25 then
    if love.mouse.getX() >= 5 and love.mouse.getX() <= 85 and love.mouse.getY() < 550 and love.mouse.getY() >= 525 and state.coins >= 25 then
      love.graphics.setColor({191/255*0.5,196/255*0.5,196/255*0.5,1})
      love.graphics.rectangle('fill', 5, 525, 80, 25, 6, 6, 50)
      love.graphics.setColor(black)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $25', 5, 525, 80, 'center')
    else 
      love.graphics.setColor({191/255,196/255,196/255,1})
      love.graphics.rectangle('fill', 5, 525, 80, 25, 6, 6, 50)
      love.graphics.setColor(semiBlack)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $25', 5, 525, 80, 'center')
    end
  end

  if state.coins >= 100 then
    if love.mouse.getX() >= 5 and love.mouse.getX() <= 85 and love.mouse.getY() < 525 and love.mouse.getY() >= 500 and state.coins >= 100 then
      love.graphics.setColor({223/255*0.5,175/255*0.5,62/255*0.5,1})
      love.graphics.rectangle('fill', 5, 500, 80, 25, 6, 6, 50)
      love.graphics.setColor(black)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $100', 5, 500, 80, 'center')
    else 
      love.graphics.setColor({223/255,175/255,62/255,1})
      love.graphics.rectangle('fill', 5, 500, 80, 25, 6, 6, 50)
      love.graphics.setColor(semiBlack)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $100', 5, 500, 80, 'center')
    end
  end

  if state.coins >= 1000 then
    if love.mouse.getX() >= 5 and love.mouse.getX() <= 85 and love.mouse.getY() < 500 and love.mouse.getY() >= 475 and state.coins >= 1000 then
      love.graphics.setColor({216/255*0.5,181/255*0.5,181/255*0.5,1})
      love.graphics.rectangle('fill', 5, 475, 80, 25, 6, 6, 50)
      love.graphics.setColor(black)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $1000', 5, 475, 80, 'center')
    else 
      love.graphics.setColor({216/255,181/255,181/255,1})
      love.graphics.rectangle('fill', 5, 475, 80, 25, 6, 6, 50)
      love.graphics.setColor(semiBlack)
      love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
      love.graphics.printf('FLIP $1000', 5, 475, 80, 'center')
    end
  end
  
  local turnDone = true
  for i = 1, 3 do
    if currentTurn[i].used == false then
      turnDone = false
    end
  end
  if turnDone == true then
    if love.mouse.getX() >= (800-100-5) and love.mouse.getX() <= 800-5 and love.mouse.getY() <= 600 and love.mouse.getY() >= (600-30) then
      love.graphics.setColor({43/255*0.5,181/255*0.5,102/255*0.5,1})
      love.graphics.rectangle('fill', 800-100-5, 600-30, 100, 30, 6, 6, 50)
      love.graphics.setNewFont("font.ttf", 24):setLineHeight(0.75)
      love.graphics.printf({{0,0,0,1},'NEXT'}, 800-100-5, 600-35,100,'center')
    else 
      love.graphics.setColor({43/255,181/255,102/255,1})
      love.graphics.rectangle('fill', 800-100-5, 600-30, 100, 30, 6, 6, 50)
      love.graphics.setNewFont("font.ttf", 24):setLineHeight(0.75)
      love.graphics.printf({{0,0,0,0.75},'NEXT'}, 800-100-5, 600-35,100,'center')
    end
  end
end

state.drawGameOver = function(currentTurn)
  local black = {0,0,0,1}
  local semiBlack = {0,0,0,0.75}
  local width = 200
  local height = 300
  local x = 800/2 - 226/2
  local y = 80
  local r = 40
  local circleX = x+226/2
  local circleY = y+270
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(image.cardGameOver, x, y)
  love.graphics.setNewFont("font.ttf", 24):setLineHeight(0.75)
  love.graphics.printf({black, "Game Over"}, x+13, y+10, width, "center")
  love.graphics.setNewFont("font.ttf", 16):setLineHeight(0.75)
  love.graphics.printf({semiBlack, "You started from nothing and clawed your way through " .. state.day-1 .. " arduous " ..(state.day > 1 and "days" or "day")..". But in the end, it doesn't even matter."}, x+13, y+55, width)
    if math.sqrt(math.pow(love.mouse.getX() - circleX, 2) + math.pow(love.mouse.getY() - circleY, 2)) <= r then
      love.graphics.setColor(0,0,0,0.4)
    else
      love.graphics.setColor(0,0,0,0.15)
    end
    love.graphics.setLineWidth(4)
    love.graphics.circle("line", circleX, circleY, r, 100)
  if math.sqrt(math.pow(love.mouse.getX() - circleX, 2) + math.pow(love.mouse.getY() - circleY, 2)) <= r then
    love.graphics.setColor(0,0,0,0.55)
  else
    love.graphics.setColor(0,0,0,0.3)
  end
  love.graphics.circle("fill", circleX, circleY, r-1, 100)
  love.graphics.setColor(0,0,0,1)
  love.graphics.setNewFont("font.ttf", 18):setLineHeight(0.75)
  love.graphics.printf({black,"Restart"}, x+226/2-29, y+257, 60, "center")
end

state.mousepressed = function(currentTurn, mx,my) 
  if mx >= 5 and mx <= 85 and my < 600 and my >= 575 and state.coins >= 1 then
    state.coins = state.coins - 1
    table.insert(currentTurn.coins, coin.new(state, 1))
  end 

  if mx >= 5 and mx <= 85 and my < 575 and my >= 550 and state.coins >= 5 then
    state.coins = state.coins - 5
    table.insert(currentTurn.coins, coin.new(state, 5))
  end 

  if mx >= 5 and mx <= 85 and my < 550 and my >= 525 and state.coins >= 25 then
    state.coins = state.coins - 25 
    table.insert(currentTurn.coins, coin.new(state, 25))
  end 

  if mx >= 5 and mx <= 85 and my < 525 and my >= 500 and state.coins >= 100 then
    state.coins = state.coins - 100 
    table.insert(currentTurn.coins, coin.new(state, 100))
  end 

  if mx >= 5 and mx <= 85 and my < 500 and my >= 475 and state.coins >= 1000 then
    state.coins = state.coins - 1000 
    table.insert(currentTurn.coins, coin.new(state, 1000))
  end 
  

  local turnDone = true
  for i = 1, #currentTurn do
    if currentTurn[i].used == false then
      turnDone = false
    end
  end
  if turnDone == true and mx >= (800-100-5) and mx <= 800-5 and my <= 600 and my >= (600-30) then
    state.day = state.day + 1
    state.newTurn(state)
  end

  if state.gameOver then
    local width = 200
    local height = 300
    local x = 800/2 - 226/2
    local y = 80
    local r = 40
    local circleX = x+226/2
    local circleY = y+270
    if (math.sqrt(math.pow(mx - circleX, 2) + math.pow(my - circleY, 2)) <= r) then
      state.initializeState()
    end
  end
end

getEvents = function(state)
  local possibleEvents = {}
  local cumulativeWeight = 0
  local weights = {}
  local weight = 0;
  for k, event in pairs(event.allEvents) do
    if (event.condition == nil) or (event.condition(state)) then
      if type(event.weight) == 'nil' then
        weight = 1
      elseif type(event.weight) == 'number' then
        weight = event.weight
      elseif type(event.weight) == 'function' then
        weight = event.weight(state)
      end
      cumulativeWeight = cumulativeWeight + weight
      table.insert(weights, cumulativeWeight)
      table.insert(possibleEvents, event)
    end
  end
  return {
    totalWeight = cumulativeWeight,
    events = possibleEvents,
    weights = weights
  }
end

pickEvent = function(possible)
  pickedWeight = love.math.random() * possible.totalWeight
  for i, event in ipairs(possible.events) do
    weight = possible.weights[i]
    if pickedWeight < weight then
      return event
    end
  end
  return possible.events[#possible.events]
end

state.newTurn = function(state, shouldLoad)
  bg = love.math.random(8)
  local turn = {
    coins = {}
  }
  
  if state.hp <= 0 then
    state.gameOver = true
  elseif shouldLoad then
    savefile.load(state)
  else
    possible = getEvents(state)
    for i = 1,3 do
      table.insert(turn, {
                    event = pickEvent(possible),
                    used = false,
                    x = 20 + (i-1)*(226 + 41),
                    y = 80,
      })
    end
    state.currentTurn = turn
  end
  savefile.save(state)
  savefile.load(state)
end

return state
