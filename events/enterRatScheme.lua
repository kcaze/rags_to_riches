local rat = require("../items/rat");
local image = require("../image")

return {
  name = "A ratty proposal",
  amount = 5,
  weight = 0.5,
  condition = function (state)
    return state.coins >= 5 and state.ratLevel == 0
  end,
  description = "A sketchy man in a trenchcoat approaches you. For only $5, you may join the Rat Club and get 4 wonderful rats you can sell.",
  heads = {
    effectDescription = "+4 rats",
    effect = function (state)
      for i = 1,4 do
        table.insert(state.items, rat)
      end
      state.ratLevel = 1
      return {
        description = "The man hands you a rat insigna and 4 rats. You are part of Rat Club! Now go and sell these rats",
        image = image.rat4,
      }
    end
  },
  tails = {
    effectDescription = "+10 coins",
    effect = function (state)
      state.coins = state.coins + 10
      return {
        description = [[You are angry at the suggestion. "I will NOT join your rat scheme!" you say as you punch the guy. He runs away, but leaves 10 coins behind in his confusion.]],
        image = image.placeholder,
      }
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
