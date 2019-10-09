local item = require("../item");
local image = require("../image")

return {
  name = "Stormy weather",
  amount = 5,
  weight = 0.25,
  condition = function(state)
    return state.coins >= 10 and state.hp >= 10
  end,
  description = "Dark clouds are looming above you.",
  heads = {
    effectDescription = "+1 red fish",
    effect = function (state)
      table.insert(state.items, item.redFish)
      return {
        description = "You stay outside. It's raining... red fish? You catch one in the process.",
        image = image.fishRed,
      }
    end
  },
  tails = {
    effectDescription = "+3 rats",
    effect = function (state)
      table.insert(state.items, item.rat)
      table.insert(state.items, item.rat)
      table.insert(state.items, item.rat)
      return {
        description = "You hide in a cave. A group of rats approaches you. You manage to befriend 3 of them.",
        image = image.rat3,
      }
    end
  },
  beg = {
    effectDescription = "-5 hp",
    effect = function (state)
      state.hp = state.hp - 5
      return {
        description = "Ack! You get caught in the thunderstorm and harmed by debris. You lose 5 hp.",
        image = image.thundercloud,
      }
    end
  }
}
