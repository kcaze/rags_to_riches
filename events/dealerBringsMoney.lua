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
    effectDescription = "-1 dealer, +100 coins (50%), -1 dealer (50%)",
    effect = function (state)
      local p = love.math.random()
      table.delete(state.items, item.dealer)
      state.ratsSold = state.ratsSold + 4
      if p < 0.5 then
        state.coins = state.coins + 100
        return {
          description = [[You negotiate a really good deal and obtain 100 coins!]],
          image = image.plus100,
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
    effectDescription = "-1 dealer, +50 coins",
    effect = function (state)
      state.coins = state.coins + 50
      table.delete(state.items, item.dealer)
      state.ratsSold = state.ratsSold + 4
      return {
        description = [[You collect 50 coins as per usual.]],
        image = image.plus50,
      }
    end
  },
  beg = {
    effectDescription = "-1 dealer +25 coins (50%), +10 coins (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        table.delete(state.items, item.dealer)
        state.ratsSold = state.ratsSold + 4
        state.coins = state.coins + 25
        return {
          description = [[You negotiate with the dealer, and he hands you 25 coins.]],
          image = image.plus25,
        }
      else
        state.coins = state.coins + 10
        return {
          description = [[The dealer pities you and hands you 10 coins.]],
          image = image.plus10,
        }
        
      end
    end
  }
}
