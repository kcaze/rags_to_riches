local item = require("../item")
local image = require("../image")

return {
  name = "Rat factory",
  amount = 100,
  weight = 0.5,
  condition = function (state)
    return state.coins >= 100 and state.ratLevel >= 3
  end,
  description = "You can make a new deal with a rat factory!",
  heads = {
    effectDescription = "+2 rat factory (50%), +1 dealer (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        state.ratsSold = state.ratsSold + 16
        table.insert(state.items, item.factory)
        table.insert(state.items, item.factory)
        return {
          description = [[The factory turns out to be so big, it counts pretty much like 2 factories. Lucky you!]],
          image = image.placeholder,
        }
      else
        table.insert(state.items, item.dealer)
        return {
          description = [[The "factory" is actually just one dealer. Heh.]],
          image = image.dealer
        }
      end
    end
  },
  tails = {
    effectDescription = "+1 rat factory (80%), ??? (20%)",
    effect = function (state)
      local p = love.math.random()
      if state.ratLevel == 4 then
        p = 0
      end
      if p < 0.8 then
        state.ratsSold = state.ratsSold + 8
        table.insert(state.items, item.factory)
        return {
          description = [[It's a standard factory. Nice.]],
          image = image.factory,
        }
      else
        state.ratLevel = 4
        return {
          description = [[This rat factory has deep connections. You now qualify for rat master!]],
          image = image.placeholder
        }
      end
    end
  },
  beg = {
    effectDescription = "-5 hp -5 coins (75%) +1 dealer (25%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.75 then
        state.hp = state.hp - 5
        state.coins = state.coins - 5
        return {
          description = [[You beg the factory. In the confusion, a rat jumps on you and steals 5 coins and hurts you. You lose 5 hp. ]],
          image = image.placeholder,
        }
      else
        table.insert(state.items, item.dealer)
        return {
          description = [[You beg the factory for a deal, they pity and give you one dealer. Not too shabby. ]],
          image = image.dealer,
        }
      end
    end
  }
}
