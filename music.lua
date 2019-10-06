local music = {}
for i, name in ipairs(love.filesystem.getDirectoryItems('music')) do
  local n = string.gsub(name, "(.*)%.(.*)", "%1")
  music[n] = love.audio.newSource("music/" .. name, "stream")
end
return music