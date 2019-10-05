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
end

state.getTurn = function()
  local turn = {}
  for i = 1,3 do
    table.insert(turn, event.allEvents[love.math.random(#event.allEvents)])
  end
  return turn
end

return state