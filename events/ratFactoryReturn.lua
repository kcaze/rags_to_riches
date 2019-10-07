local item = require("../item")
local image = require("../image")

return {
  name = "Rat factory return",
  amount = 25,
  condition = function (state)
    return table.contains(state.items, item.factory) and state.ratLevel >= 3
  end,
  description = "One of your rat factories has sold all its rats!",
  heads = {
    effectDescription = "+100 coins, -1 rat factory (50%) +20 coins, -1 rat factory (50%)",
    effect = function (state)
      local p = love.math.random()
      table.delete(state.items, item.factory)
      if p < 0.5 then
        state.coins = state.coins + 100
        return {
          description = [[It's your lucky day! The factory did much better than anyone expected, and you get a big share of 100 coins! ]],
          image = image.plus100,
        }
      else
        state.coins = state.coins + 20
        return {
          description = [[The factory underperformed this time, but you still get 20 coins.]],
          image = image.plus20,
        }
      end
    end
  },
  tails = {
    effectDescription = "+50 coins, -1 rat factory",
    effect = function (state)
      state.coins = state.coins + 50
      table.delete(state.items, item.factory)
      return {
        description = [[The factory performed right on average, giving you a solid 50 coins.]],
        image = image.plus50,
      }
    end
  },
  beg = {
    effectDescription = "+10 coins (50%), -1 rat factory (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        state.hp = state.coins + 10
        return {
          description = [[The factory pities you, it'll keep going and you get 10 coins to get back on your feet.]],
          image = image.plus10,
        }
      else
        table.delete(state.items, item.factory)
        return {
          description = [[The factory exploded, you get nothing.]],
          image = image.explosion,
        }
      end
    end
  }
}
