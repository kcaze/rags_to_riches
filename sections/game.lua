local state = require("../state")
local music = require("../music")
local event = require("../event")
local coin = require("../coin")
local image = require("../image")
local game = {}

game.load = function()
  state.initializeState()
  --event.printEventTable()
end

game.draw = function ()
  state.draw(state.currentTurn)
  for i = 1,#state.currentTurn do
    event.draw(state.currentTurn[i])
  end
  for i = 1, #state.currentTurn.coins do
    coin.draw(state.currentTurn.coins[i])
  end
end

game.update = function (dt)
  state.update(dt)
  for i = 1, #state.currentTurn.coins do
    coin.update(state.currentTurn.coins[i])
  end
end

game.mousepressed = function (x,y,button)
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
  for i = 1,#state.currentTurn do
    event.mousepressed(state,state.currentTurn[i],x,y)
  end
  state.mousepressed(state.currentTurn,x,y)
end

game.mousereleased = function (x,y,button)
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

return game
