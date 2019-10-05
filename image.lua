local image = {}
for i, name in ipairs(love.filesystem.getDirectoryItems('images')) do
  local n = string.gsub(name, "(.*)%.(.*)", "%1")
  image[n] = love.graphics.newImage("images/" .. name)
end
return image 