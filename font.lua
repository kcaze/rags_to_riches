require("utils")

local font = {}
font.setFont = function (size)
  if not table.containsKey(font, size) then
    font[size] = love.graphics.newFont('font.ttf', size)
    font[size]:setLineHeight(0.75)
  end
  love.graphics.setFont(font[size])
end
return font