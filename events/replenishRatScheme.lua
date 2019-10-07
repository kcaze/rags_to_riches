local item = require("../item")
local image = require("../image")

return {
  name = "Get more rats",
  amount = 5,
  weight = 0.5,
  condition = function (state)
    return state.coins >= 5 and state.ratLevel == 1
  end,
  description = "The sketchy trenchcoat man returns. For only $5, you may get 4 more rats to sell.",
  heads = {
    effectDescription = "+4 rats",
    effect = function (state)
      for i = 1,4 do
        table.insert(state.items, item.rat)
      end
      return {
        description = "The man hands you 4 rats. Now go and sell these rats",
        image = image.rat4,
      }
    end
  },
  tails = {
    effectDescription = "+1 rat (50%) ??? (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        table.insert(state.items, item.rat)
        return {
          description = [[The man hands you 4 rats... but only 1 of them is real! You try to demand your money back, but he's already gone...]],
          image = image.rat,
        }
      else
        state.ratLevel = 2
        return {
          description = [[The man approaches you closer and whispers, "how would you like to join the rat gang?" You agree, and graduate to a level 2 rat dealer!]],
          image = image.dealer
        }
      end
    end
  },
  beg = {
    effectDescription = "-5 hp",
    effect = function (state)
      state.hp = state.hp - 5
      return {
        description = [[You stare at the man, unanswering. Suddenly a rat jumps out of his trenchcoat and bites you. You lose 5 hp.]],
        image = image.rat,
      }
    end
  }
}
