local inspect = require('inspect')
local coin = require('coin')
local event = require('event')
local state = {
  name="Herman",
  maxHp = 100,
  hp=100,
  coins=10,
  items={}, 
  draw = draw,
}

state.draw = function (currentTurn)
  love.graphics.setColor(1,1,1,1)
  love.graphics.print("Name: " .. state.name, 0, 0)
  love.graphics.print("Coins: " .. state.coins, 0, 20)
  love.graphics.print("HP: " .. state.hp .. "/" .. state.maxHp, 0, 40)
  love.graphics.setColor({1,1,1,1})
  love.graphics.rectangle('fill', 0, 550, 150, 50)
  if love.mouse.getX() >= 0 and love.mouse.getX() <= 150 and love.mouse.getY() <= 600 and love.mouse.getY() >= 550 and state.coins > 0 then
    love.graphics.setColor({1,0,0,1})
  else 
    love.graphics.setColor({0,0,0,1})
  end
  love.graphics.print('FLIP', 40, 555,0,2.5,2.5)
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
  if mx >= 0 and mx <= 150 and my <= 600 and my >= 550 and state.coins > 0 then
    love.graphics.setColor({1,0,0,1})
    state.coins = state.coins - 1
    table.insert(currentTurn.coins, coin.new(state, 1))
  end 
  local turnDone = true
  for i = 1, 3 do
    if currentTurn[i].used == false then
      turnDone = false
    end
  end
  if turnDone == true and mx >= (800-150) and mx <= 800 and my <= 600 and my >= 550 then
    state.newTurn(state)
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
