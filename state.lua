local state = {
  name="Herman",
  maxHp = 100,
  hp=100,
  coins=0,
  items={}, 
  draw = draw,
}

state.draw = function ()
  love.graphics.print("Name: " .. state.name, 0, 0)
  love.graphics.print("Coins: " .. state.coins, 0, 20)
end

state.getTurn = function()
  return []

return state