require('utils')
local image = require("../image")

return {
  name = "Beg for food",
  amount = 1,
  condition = function (state)
    return state.coins < 10 
  end,
  description = "You approach a bread vendor and beg for some food.",
  heads = {
    effectDescription = "+3 hp",
    effect = function (state)
      state.hp = state.hp + 3
      return {
        description = "The vender generously hands you a loaf of bread that you immediately scarf down. You gain 3 hp.",
        image = image.placeholder,
        win = true
      }
    end
  },
  tails = {
    effectDescription = "+1 hp, +1 coin",
    effect = function (state)
      state.hp = state.hp + 1
      state.coins = state.coins + 1
      return {
        description = "The vender refuses but you chase down a nearby pigeon that stole a scrap of bread and $1 from the vendor.",
        image = image.placeholder
      }
    end
  },
  beg = {
    effectDescription = "No effect",
    effect = function (state)
      return {
        description = "The vender shooes you away.",
        image = image.placeholder
      }
    end
  }
}
