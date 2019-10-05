local state = require("state")
local event = require("event")
local coin = require("coin")
state.newTurn(state)

function love.draw()
  for i = 1,3 do
    event.draw(state.currentTurn[i])
  end
  state.draw(state.currentTurn)
  for i = 1, #state.currentTurn.coins do
    coin.draw(state.currentTurn.coins[i])
  end
end

function love.update()
  for i = 1, #state.currentTurn.coins do
    coin.update(state.currentTurn.coins[i])
  end
end

function love.mousepressed(x,y,button)
  if button ~= 1 then
    return
  end

  -- Reverse order from drawing so the top most coin gets priority in dragging.
  for i = #state.currentTurn.coins,1,-1 do
    local c = state.currentTurn.coins[i]
    if math.sqrt(math.pow(x - c.x,2) + math.pow(y-c.y,2)) <= 30 then
      coin.mousepressed(state.currentTurn.coins[i],x,y)
      return
    end
  end
  for i = 1,3 do
    event.mousepressed(state,state.currentTurn[i],x,y)
  end
  state.mousepressed(state.currentTurn,x,y)
end

function love.mousereleased(x,y,button)
  if button ~= 1 then
    return
  end
  for i = 1, #state.currentTurn.coins do
    if state.currentTurn.coins[i].dragging then
      coin.mousereleased(state, state.currentTurn, state.currentTurn.coins[i],x,y)
      break
    end
  end
end

function love.conf(t)
	t.console = true
end
