local event = {
  allEvents = {},
}

-- Draw event e with the top-left position being (x,y).
event.draw = function (e, x, y)
  local black = {0,0,0,1}
  local width = 200
  local height = 300
  love.graphics.setColor(1,1,1,1)
  love.graphics.rectangle("fill", x, y, width, height)
  love.graphics.printf({black, e.name}, x, y, width)
  love.graphics.printf({black, e.description}, x, y+40, width)
  love.graphics.printf({black, "Heads: " .. e.heads.effectDescription}, x, y+120, width)
  love.graphics.printf({black, "Tails: " .. e.tails.effectDescription}, x, y+120+30, width)
  love.graphics.printf({black, "Beg: " .. e.beg.effectDescription}, x, y+120+30*2, width)
  love.graphics.setColor(0,0,0,1)
  love.graphics.print({black, "BEG"}, x+width/2-12, y+243)
  love.graphics.circle("line", x+width/2, y+250, 30)
end

-- Load all events.
for i, name in ipairs(love.filesystem.getDirectoryItems('events')) do
  table.insert(event.allEvents, require("events/" .. string.gsub(name, "(.*)%.(.*)", "%1")))
end

return event