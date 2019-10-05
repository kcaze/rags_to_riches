local item = {}
for i, name in ipairs(love.filesystem.getDirectoryItems('items')) do
  local n = string.gsub(name, "(.*)%.(.*)", "%1")
  item[n] = love.graphics.newImage("images/" .. n)
end
return item 