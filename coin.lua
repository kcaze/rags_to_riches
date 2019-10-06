require('utils')
local image = require('image')
local font = require('font')

local coin = {}

local coinImages = {}
coinImages[1] = image.coin1
coinImages[5] = image.coin5
coinImages[25] = image.coin25
coinImages[100] = image.coin100
coinImages[1000] = image.coin1000

coin.new = function (state,amount)
  return {
    x = love.math.random(200,700),
    y = love.math.random(500,570),
    value = (love.math.random(2) == 1) and 'heads' or 'tails',
    amount = amount,
    dragging = false,
  }
end

coin.draw = function (c)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(coinImages[c.amount], c.x-30, c.y-30)
  font.setFont(24)
  if c.value == 'heads' then
    love.graphics.printf({{0,0,0,1},"H"}, c.x-29, c.y-19, 60, "center")
  else
    love.graphics.printf({{0,0,0,1},"T"}, c.x-29, c.y-19, 60, "center")
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
      local circleX = obj.x+226/2
      local circleY = obj.y+305
      if (obj.used == false) and obj.event.amount <= c.amount and (math.sqrt(math.pow(mx - circleX, 2) + math.pow(my - circleY, 2)) <= 40) then
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