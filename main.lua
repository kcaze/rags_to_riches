local state = require("state")
local event = require("event")
local currentTurn = state.getTurn()

function love.draw()
  for i = 1,3 do
    event.draw(currentTurn[i], 50 + (i-1)*250, 100)
  end
  state.draw()
end

function love.update()
  state.getTurn()
end

function love.conf(t)
	t.console = true
end