local state = require("state")
local event = require("event")
local currentTurn = state.getTurn()

function love.draw()
  for i = 1,3 do
    event.draw(currentTurn[i])
  end
  state.draw()
end

function love.update()
  state.getTurn()
end

function love.mousepressed(x,y,button)
  if button ~= 1 then
    return
  end

  for i = 1,3 do
    event.mousepressed(state,currentTurn[i],x,y)
  end
end

function love.conf(t)
	t.console = true
end