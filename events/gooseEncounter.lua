require('utils')
local image = require("../image")

return {
  name = "Meet an untitled goose",
  amount = 5,
  weight = 0.2,
  condition = function (state)
    return state.coins >= 5
  end,
  description = "The mischievous goose honks at you.",
  heads = {
    effectDescription = "+25 coin (30%)",
    effect = function (state)
      if love.math.random() <= 0.3 then
        state.coins = state.coins + 25 
        return {
          description = "Holy crap, the goose laid a gold egg! You take it and sell it for $25.",
          image = image.gooseWithGoldEgg
        }
      else 
        return {
          description = "HOOOONNNNNKKK!",
          image = image.goose
        }
      end
    end
  },
  tails = {
    effectDescription = "+8 coin",
    effect = function (state)
      state.coins = state.coins + 8 
      return {
        description = "You steal the goose's egg and sell it for 8 coin.",
        image = image.gooseWithBlueEgg
      }
    end
  },
  beg = {
    effectDescription = "+1 coin",
    effect = function (state)
      state.coins = state.coins + 1 
      return {
        description = "Is that a... stone egg? You steal it anyways and manage to sell it off for 1 coin.",
        image = image.gooseWithStoneEgg
      }
    end
  }
}
