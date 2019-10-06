local image = {}
for i, name in ipairs(love.filesystem.getDirectoryItems('images')) do
  local n = string.gsub(name, "(.*)%.(.*)", "%1")
  image[n] = love.graphics.newImage("images/" .. name)
end
for i = 1, 8 do
  local bg = image['bg'..i]
  bg:setWrap("repeat", "repeat")
  image['bg'..i..'Quad'] = love.graphics.newQuad(0,0,800,600,bg:getWidth(),bg:getHeight())
end
local mainMenuBg = image.mainMenuBg
mainMenuBg:setWrap("repeat", "repeat")
image.mainMenuBgQuad = love.graphics.newQuad(0,0,800,600,mainMenuBg:getWidth(),mainMenuBg:getHeight())
return image 