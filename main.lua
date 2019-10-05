local state = require("state")
local event = require("event")
local coin = require("coin")
local currentTurn = state.getTurn(state)
for i = 1,2 do
  table.insert(currentTurn.coins, coin.new(love.math.random(400), love.math.random(400),(love.math.random(2) == 1) and 'heads' or 'tails'))
end

function love.draw()
  for i = 1,3 do
    event.draw(currentTurn[i])
  end
  state.draw()
  for i = 1, #currentTurn.coins do
    coin.draw(currentTurn.coins[i])
  end
end

function love.update()
  for i = 1, #currentTurn.coins do
    coin.update(currentTurn.coins[i])
  end
end

function love.mousepressed(x,y,button)
  if button ~= 1 then
    return
  end

  for i = 1,3 do
    event.mousepressed(state,currentTurn[i],x,y)
  end
  -- Reverse order from drawing so the top most coin gets priority in dragging.
  for i = #currentTurn.coins,1,-1 do
    local c = currentTurn.coins[i]
    if math.sqrt(math.pow(x - c.x,2) + math.pow(y-c.y,2)) <= 30 then
      coin.mousepressed(currentTurn.coins[i],x,y)
      break
    end
  end
end

function love.mousereleased(x,y,button)
  if button ~= 1 then
    return
  end
  for i = 1, #currentTurn.coins do
    coin.mousereleased(currentTurn.coins[i],x,y)
  end
end

function love.conf(t)
	t.console = true
end
