local event = {
  allEvents = {},
}

-- Draw event e.
event.draw = function (obj)
  local x = obj.x
  local y = obj.y
  local e = obj.event
  local black = {0,0,0,1}
  local width = 200
  local height = 300
  love.graphics.setColor(1,1,1,1)
  love.graphics.rectangle("fill", x, y, width, height)
  if obj.used == false then
    love.graphics.printf({black, e.name .. " ($" .. e.amount .. ")"}, x, y, width)
    love.graphics.printf({black, e.description}, x, y+40, width)
    love.graphics.printf({black, "Heads: " .. e.heads.effectDescription}, x, y+120, width)
    love.graphics.printf({black, "Tails: " .. e.tails.effectDescription}, x, y+120+30, width)
    love.graphics.printf({black, "Beg: " .. e.beg.effectDescription}, x, y+120+30*2, width)
    local circleX = x+width/2
    local circleY = y+250
    local r = 30
    if math.sqrt(math.pow(love.mouse.getX() - circleX, 2) + math.pow(love.mouse.getY() - circleY, 2)) <= r then
      love.graphics.setColor(1,0,0,1)
    else
      love.graphics.setColor(0,0,0,1)
    end
    love.graphics.print("BEG", x+width/2-12, y+243)
    love.graphics.circle("line", circleX, circleY, 30)
  elseif obj.used == 'beg' then
    love.graphics.printf({black, obj.description}, x, y, width)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(obj.image, x, y+100)
  elseif obj.used == 'heads' then
    love.graphics.printf({black, obj.description}, x, y, width)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(obj.image, x, y+100)
  elseif obj.used == 'tails' then
    love.graphics.printf({black, obj.description}, x, y, width)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(obj.image, x, y+100)
  end
end

-- Primary mouse press on event e.
event.mousepressed = function (state, obj, mx, my)
  local e = obj.event
  local x = obj.x
  local y = obj.y
  local circleX = x+200/2
  local circleY = y+250
  local r = 30
  if (math.sqrt(math.pow(mx - circleX, 2) + math.pow(my - circleY, 2)) <= r) and obj.used == false then
    local outcome = e.beg.effect(state)
    obj.used = 'beg'
    obj.description = outcome.description
    obj.image = outcome.image
  end
end

-- Load all events.
for i, name in ipairs(love.filesystem.getDirectoryItems('events')) do
  table.insert(event.allEvents, require("events/" .. string.gsub(name, "(.*)%.(.*)", "%1")))
end

return event
