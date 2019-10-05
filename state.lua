local inspect = require('inspect')
local coin = require('coin')
local event = require('event')
local state = {
  maxHp = 100,
  hp=100,
  coins=0,
  items={}, 
  day = 1,
  draw = draw,
}

state.draw = function (currentTurn)
  love.graphics.setColor(1,1,1,1)
  love.graphics.print("Day: " .. state.day, 0, 0)
  love.graphics.print("Coins: " .. state.coins, 0, 20)
  love.graphics.print("HP: " .. state.hp .. "/" .. state.maxHp, 0, 40)

  if state.coins >= 1 then
    love.graphics.setColor({1,1,1,1})
    love.graphics.rectangle('fill', 0, 575, 80, 25)
    if love.mouse.getX() >= 0 and love.mouse.getX() <= 80 and love.mouse.getY() <= 600 and love.mouse.getY() >= 575 and state.coins > 0 then
      love.graphics.setColor({1,0,0,1})
    else 
      love.graphics.setColor({0,0,0,1})
    end
    love.graphics.print('FLIP $1', 0, 575,0,1.5,1.5)
  end

  if state.coins >= 5 then
    love.graphics.setColor({1,1,1,1})
    love.graphics.rectangle('fill', 0, 575-25, 80, 25)
    if love.mouse.getX() >= 0 and love.mouse.getX() <= 80 and love.mouse.getY() < 575 and love.mouse.getY() >= 550 and state.coins > 0 then
      love.graphics.setColor({1,0,0,1})
    else 
      love.graphics.setColor({0,0,0,1})
    end
    love.graphics.print('FLIP $5', 0, 550,0,1.5,1.5)
  end 

  if state.coins >= 10 then
    love.graphics.setColor({1,1,1,1})
    love.graphics.rectangle('fill', 0, 575-2*25, 80, 25)
    if love.mouse.getX() >= 0 and love.mouse.getX() <= 80 and love.mouse.getY() < 550 and love.mouse.getY() >= 525 and state.coins > 0 then
      love.graphics.setColor({1,0,0,1})
    else 
      love.graphics.setColor({0,0,0,1})
    end
    love.graphics.print('FLIP $10', 0, 525,0,1.5,1.5)
  end

  if state.coins >= 25 then
    love.graphics.setColor({1,1,1,1})
    love.graphics.rectangle('fill', 0, 575-3*25, 80, 25)
    if love.mouse.getX() >= 0 and love.mouse.getX() <= 80 and love.mouse.getY() < 525 and love.mouse.getY() >= 500 and state.coins > 0 then
      love.graphics.setColor({1,0,0,1})
    else 
      love.graphics.setColor({0,0,0,1})
    end
    love.graphics.print('FLIP $25', 0, 500,0,1.5,1.5)
  end
  
  local turnDone = true
  for i = 1, 3 do
    if currentTurn[i].used == false then
      turnDone = false
    end
  end
  if turnDone == true then
    love.graphics.setColor({1,1,1,1})
    love.graphics.rectangle('fill', 800-150, 550, 150, 50)
    if love.mouse.getX() >= (800-150) and love.mouse.getX() <= 800 and love.mouse.getY() <= 600 and love.mouse.getY() >= 550 then
      love.graphics.setColor({1,0,0,1})
    else 
      love.graphics.setColor({0,0,0,1})
    end
    love.graphics.print('NEXT', 800-150+40, 555,0,2.5,2.5)
  end
end

state.mousepressed = function(currentTurn, mx,my) 
  if mx >= 0 and mx <= 80 and my < 600 and my >= 575 and state.coins >= 1 then
    state.coins = state.coins - 1
    table.insert(currentTurn.coins, coin.new(state, 1))
  end 

  if mx >= 0 and mx <= 80 and my < 575 and my >= 550 and state.coins >= 5 then
    state.coins = state.coins - 5
    table.insert(currentTurn.coins, coin.new(state, 5))
  end 

  if mx >= 0 and mx <= 80 and my < 550 and my >= 525 and state.coins >= 10 then
    state.coins = state.coins - 10 
    table.insert(currentTurn.coins, coin.new(state, 10))
  end 

  if mx >= 0 and mx <= 80 and my < 525 and my >= 500 and state.coins >= 25 then
    state.coins = state.coins - 25 
    table.insert(currentTurn.coins, coin.new(state, 25))
  end 
  

  local turnDone = true
  for i = 1, 3 do
    if currentTurn[i].used == false then
      turnDone = false
    end
  end
  if turnDone == true and mx >= (800-150) and mx <= 800 and my <= 600 and my >= 550 then
    state.newTurn(state)
    state.day = state.day + 1
  end
end

state.newTurn = function(state)
  local turn = {
    coins = {}
  }

  possibleEvents = {}
  for i, event in ipairs(event.allEvents) do
    if (event.condition == nil) or (event.condition(state)) then
      table.insert(possibleEvents, event);
    end
  end
  
  for i = 1,3 do
    table.insert(turn, {
                   event = possibleEvents[love.math.random(#possibleEvents)],
                   used = false,
                   x = 50 + (i-1)*250,
                   y = 100,
    })
  end
  state.currentTurn = turn
end

return state
