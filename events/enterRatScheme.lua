local rat = require("../items/rat");
local image = require("../image")

return {
  name = "A ratty proposal",
  amount = 5,
  weight = 1,
  description = "A sketchy man in a trenchcoat approaches you. If you join the Rat Club, he'll give you 4 wonderful Rats at a discount for you to sell.",
  heads = {
    effectDescription = "+4 rats",
    effect = function (state)
      for i = 1,4 do
        table.insert(state.items, rat)
      end
      state.ratLevel = 1
      return {
        description = "The man hands you a rat insigna. You are part of Rat Club! Now go and sell these rats",
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
    effectDescription = "-5 HP",
    effect = function (state)
      state.hp = state.hp - 5
      return {
        description = [[You stare at the man, unanswering. Suddenly a rat jumps out of his trenchcoat and bites you.]],
        image = image.rat,
      }
    end
  }
}
