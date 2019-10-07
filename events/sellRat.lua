require('utils')
local item = require("../item")
local image = require("../image")

return {
  name = "Sell a rat",
  amount = 1,
  condition = function (state)
    return table.contains(state.items, item.rat) and state.ratLevel >= 1
  end,
  description = "You have a rat to sell!",
  heads = {
    effectDescription = "-1 rat, +25 coins (25%) -1 rat (75%)",
    effect = function (state)
      local p = love.math.random()
      table.delete(state.items, item.rat)
      state.ratsSold = state.ratsSold + 1
      if p < 0.25 then
        state.coins = state.coins + 25
        return {
          description = "You approach a wealthy merchant with an offer he can't refuse. He... does not refuse. You sell a rat for 25 coins!",
          image = image.plus25,
        }
      else
        return {
          description = "You approach a wealthy merchant but stumble with your words. He kicks you and your rat runs away.",
          image = image.bad,
        }
      end
    end
  },
  tails = {
    effectDescription = "-1 rat, +3 coins",
    effect = function (state)
      state.coins = state.coins + 3
      table.delete(state.items, item.rat)
      state.ratsSold = state.ratsSold + 1
      return {
        description = [[You sell the rat to the olde pet shop for 3 coins.]],
        image = image.plus3,
      }
    end
  },
  beg = {
    effectDescription = "-1 rat and +5 coins (20%), -2 hp (80%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.2 then
        table.delete(state.items, item.rat)
        state.ratsSold = state.ratsSold + 1
        state.coins = state.coins + 5
        return {
          description = [[You stumble upon a rat lover and talk up the rat you have. She buys your rat for 5 whole coins!]],
          image = image.plus5,
        }
      else
        state.hp = state.hp - 2
        return {
          description = [[You try to sell your rat to a person on the street. She gets scared and runs away. Your rat get scared too and bites you, making you lose 2 hp.]],
          image = image.bad,
        }
        
      end
    end
  }
}
