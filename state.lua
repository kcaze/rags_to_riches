local inspect = require('inspect')
local coin = require('coin')
local event = require('event')
local state = {
  name="Herman",
  maxHp = 100,
  hp=100,
  coins=0,
  items={}, 
  draw = draw,
}

state.draw = function ()
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
end

state.mousepressed = function(currentTurn, mx,my) 
  if mx >= 0 and mx <= 150 and my <= 600 and my >= 550 and state.coins > 0 then
    love.graphics.setColor({1,0,0,1})
    state.coins = state.coins - 1
    table.insert(currentTurn.coins, coin.new(state))
  end 
end

state.getTurn = function(state)
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
  return turn
end

return state
