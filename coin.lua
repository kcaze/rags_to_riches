require('utils')
local image = require('image')

local coin = {}

coin.new = function (state, x,y)
  return {
    x = love.math.random(200,700),
    y = love.math.random(500,570),
    value = (love.math.random(2) == 1) and 'heads' or 'tails',
    dragging = false,
  }
end

coin.draw = function (c)
  love.graphics.setColor(1,1,1,1)
  if c.value == 'heads' then
    love.graphics.draw(image.coinHeads, c.x-30, c.y-30)
  else
    love.graphics.draw(image.coinTails, c.x-30, c.y-30)
  end
end

coin.update = function (c)
  if c.dragging then
    c.x = love.mouse.getX()
    c.y = love.mouse.getY()
  end
end

coin.mousepressed = function (c, mx, my)
  c.dragging = true
end

coin.mousereleased = function (state, currentTurn, c, mx, my)
  if c.dragging == true then
    for i = 1,3 do
      local obj = currentTurn[i]
      local circleX = obj.x+200/2
      local circleY = obj.y+250
      if (obj.used == false) and (math.sqrt(math.pow(mx - circleX, 2) + math.pow(my - circleY, 2)) <= 40) then
        if c.value == 'heads' then
          local outcome = obj.event.heads.effect(state)
          obj.description = outcome.description
          obj.image = outcome.image
        else 
          local outcome = obj.event.tails.effect(state)
          obj.description = outcome.description
          obj.image = outcome.image
        end
        obj.used = c.value
        table.delete(currentTurn.coins, c)
      end
    end
    c.dragging = false
  end
end


return coin