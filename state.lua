local inspect = require('inspect')
local coin = require('coin')
local event = require('event')
local image = require('image')
local state = {
  hp=100,
  coins=1000,
  items={}, 
  day = 1,
  draw = draw,
  ratLevel = 0,
  ratsSold = 0
}

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
  love.graphics.print("Day: " .. state.day, 5, 0)
  love.graphics.print("Coins: " .. state.coins, 5, 20)
  love.graphics.print("HP: " .. state.hp, 5, 40)

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
  for i = 1, 3 do
    if currentTurn[i].used == false then
      turnDone = false
    end
  end
  if turnDone == true and mx >= (800-100-5) and mx <= 800-5 and my <= 600 and my >= (600-30) then
    state.newTurn(state)
    state.day = state.day + 1
  end
end

getEvents = function(state)
  local possibleEvents = {}
  local cumulativeWeight = 0
  local weights = {}
  local weight = 0;
  for i, event in ipairs(event.allEvents) do
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

state.newTurn = function(state)
  bg = love.math.random(8)
  local turn = {
    coins = {}
  }

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

return state
