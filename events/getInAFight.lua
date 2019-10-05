require('utils')
local image = require("../image")
local item = require("../item")

return {
  name = "You get in a fight.",
  amount = 1,
  weight = 0.25,
  description = "That scruffy redheaded idiot really got on your nerves.",
  heads = {
    effectDescription = "+3 coin, -1 hp",
    effect = function (state)
        state.coins = state.coins + 3 
        state.hp = state.hp - 1 
        return {
          description = "Wham! Pow! Blam! You are victorious and take $3 from the idiot and 1 hp in the process.",
          image = image.punch
        }
    end
  },
  tails = {
    effectDescription = "-3 hp, obtain a 'Tooth'",
    effect = function (state)
      state.hp = state.hp - 3 
      table.insert(state.items, item.tooth)
      return {
        description = "Ow, a strong uppercut punches into your jaw, knocking out one of your teeth and taking 3 hp.",
        image = image.tooth
      }
    end
  },
  beg = {
    effectDescription = "-3 hp",
    effect = function (state)
      state.hp = state.hp - 3 
      return {
        description = "Ow, a strong uppercut punches into your stomach, knocking the wind out of you. You lose 3 hp.",
        image = image.punch
      }
    end
  }
}
