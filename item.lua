local item = {}
for i, name in ipairs(love.filesystem.getDirectoryItems('items')) do
  local n = string.gsub(name, "(.*)%.(.*)", "%1")
  item[n] = require("items/" .. n)
end
return item 