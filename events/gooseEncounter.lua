require('utils')
local image = require("../image")

return {
  name = "An Untitled Goose",
  amount = 5,
  weight = 0.2,
  condition = function (state)
    return state.coins >= 5
  end,
  description = "You see an mischievous untitled goose. It honks at you. HONK!",
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
    effectDescription = "+10 coin",
    effect = function (state)
      state.coins = state.coins + 10
      return {
        description = "You steal the goose's egg and sell it for 10 coin.",
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
