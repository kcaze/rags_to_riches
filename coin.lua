local coin = {}
local imgCoinHeads = love.graphics.newImage('images/coinHeads.png')
local imgCoinTails = love.graphics.newImage('images/coinTails.png')

coin.new = function (x,y,value)
  return {
    x = x,
    y = y,
    value = value,
    dragging = false
  }
end

coin.draw = function (c)
  if c.value == 'heads' then
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(imgCoinHeads, c.x-30, c.y-30)
  else
    love.graphics.draw(imgCoinTails, c.x-30, c.y-30)
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

coin.mousereleased = function (c, mx, my)
  c.dragging = false
end

return coin