local image = require('image')
local font = require('font')
local event = {
  allEvents = {},
}

local cardBackground = {}
cardBackground[1] = image.card1
cardBackground[5] = image.card5
cardBackground[25] = image.card25
cardBackground[100] = image.card100
cardBackground[1000] = image.card1000

-- Draw event e.
event.draw = function (obj)
  local x = obj.x
  local y = obj.y
  local e = obj.event
  local black = {0,0,0,1}
  local semiBlack = {0,0,0,0.75}
  local width = 200
  local height = 300
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(cardBackground[e.amount], x, y)
  font.setFont(24)
  love.graphics.printf({black, e.name}, x+13, y+10, width, "center")
  if obj.used == false then
    font.setFont(16)
    love.graphics.printf({semiBlack, e.description}, x+13, y+55, width)
    love.graphics.printf({black, "H:"}, x+13, y+140, width)
    love.graphics.printf({semiBlack, e.heads.effectDescription}, x+30, y+140, width-17)
    love.graphics.printf({black, "T:"}, x+13, y+140+45, width)
    love.graphics.printf({semiBlack, e.tails.effectDescription}, x+27, y+140+45, width-14)
    love.graphics.printf({black, "Beg:"}, x+13, y+140+45*2, width)
    love.graphics.printf({semiBlack, e.beg.effectDescription}, x+40, y+140+45*2, width-27)
    local circleX = x+226/2
    local circleY = y+305
    local r = 30
    if math.sqrt(math.pow(love.mouse.getX() - circleX, 2) + math.pow(love.mouse.getY() - circleY, 2)) <= r then
      love.graphics.setColor(0,0,0,0.5)
    else
      love.graphics.setColor(0,0,0,0.25)
    end
    love.graphics.setLineWidth(4)
    love.graphics.circle("line", circleX, circleY, 30, 100)
    if math.sqrt(math.pow(love.mouse.getX() - circleX, 2) + math.pow(love.mouse.getY() - circleY, 2)) <= r then
      love.graphics.setColor(0,0,0,0.65)
    else
      love.graphics.setColor(0,0,0,0.4)
    end
    love.graphics.circle("fill", circleX, circleY, 30-1, 100)
    love.graphics.setColor(0,0,0,1)
    font.setFont(18)
    love.graphics.printf({black,"Beg"}, x+226/2-30, y+290, 60, "center")
    love.graphics.printf({semiBlack, "$"..e.amount}, x+10, y+310, width, "right")
  elseif obj.used == 'beg' then
    font.setFont(16)
    love.graphics.printf({semiBlack, obj.description}, x+13, y+55, width)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(obj.image, x+13, y+140)
  elseif obj.used == 'heads' then
    font.setFont(16)
    love.graphics.printf({semiBlack, obj.description}, x+13, y+55, width)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(obj.image, x+13, y+140)
  elseif obj.used == 'tails' then
    font.setFont(16)
    love.graphics.printf({semiBlack, obj.description}, x+13, y+55, width)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(obj.image, x+13, y+140)
  end
end

-- Primary mouse press on event e.
event.mousepressed = function (state, obj, mx, my)
  local e = obj.event
  local x = obj.x
  local y = obj.y
  local circleX = x+226/2
  local circleY = y+305
  local r = 30
  if (math.sqrt(math.pow(mx - circleX, 2) + math.pow(my - circleY, 2)) <= r) and obj.used == false then
    local outcome = e.beg.effect(state)
    obj.used = 'beg'
    obj.description = outcome.description
    obj.image = outcome.image
  end
end

event.printEventTable = function ()
  for k, e in pairs(event.allEvents) do
    print(
      e.amount
        .. ';' .. e.name
        .. ';' .. e.description
        .. ';' .. e.heads.effectDescription 
        .. ';' .. e.tails.effectDescription
        .. ';' .. e.beg.effectDescription
    )
  end
end

-- Load all events.
for i, name in ipairs(love.filesystem.getDirectoryItems('events')) do
  n = string.gsub(name, "(.*)%.(.*)", "%1")
  e = require("events/" .. n)
  event.allEvents[n] = e
end

return event
