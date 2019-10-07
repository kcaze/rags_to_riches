local item = require("../item")
local image = require("../image")

return {
  name = "Dealer brings money",
  amount = 5,
  condition = function (state)
    return table.contains(state.items, item.dealer) and state.ratLevel >= 2
  end,
  description = "One of your dealers has executed some trades!",
  heads = {
    effectDescription = "-1 dealer, +50 coins (50%), -1 dealer (50%)",
    effect = function (state)
      local p = love.math.random()
      table.delete(state.items, item.dealer)
      state.ratsSold = state.ratsSold + 4
      if p < 0.5 then
        state.coins = state.coins + 50
        return {
          description = [[You negotiate a really good deal and obtain 50 coins!]],
          image = image.plus50,
        }
      else
        return {
          description = [[You try negotiating but it fails. The dealer leaves you, alone and coinless. ]],
          image = image.bad,
        }
      end
    end
  },
  tails = {
    effectDescription = "-1 dealer, +20 coins",
    effect = function (state)
      state.coins = state.coins + 20
      table.delete(state.items, item.dealer)
      state.ratsSold = state.ratsSold + 4
      return {
        description = [[You collect 20 coins as per usual.]],
        image = image.plus20,
      }
    end
  },
  beg = {
    effectDescription = "-1 dealer +15 coins (50%), +5 coins (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        table.delete(state.items, item.dealer)
        state.ratsSold = state.ratsSold + 4
        state.coins = state.coins + 15
        return {
          description = [[You negotiate with the dealer, and he hands you 15 coins.]],
          image = image.plus15,
        }
      else
        state.coins = state.coins + 5
        return {
          description = [[The dealer pities you and hands you 5 coins.]],
          image = image.plus5,
        }
        
      end
    end
  }
}
