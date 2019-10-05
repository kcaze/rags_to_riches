require('utils')
local image = require("../image")

return {
  name = "Begging for money",
  amount = 1,
  condition = function (state)
    return state.coins < 10
  end,
  description = "You grovel like the lowly pauper you are, begging for coins from passerbys.",
  heads = {
    effectDescription = "+2 coins (50% chance), -2 hp (50% chance)",
    effect = function (state)
      return {
        description = "Hello World",
        image = image.placeholder
      }
    end
  },
  tails = {
    effectDescription = "+2 coins (50% chance), -2 hp (50% chance)",
    effect = function (state)
      state.coins = state.coins + 5
      return {
        description = "TODO",
        image = image.placeholder
      }
    end
  },
  beg = {
    effectDescription = "Nothing",
    effect = function (state)
      if love.math.random() < 0.5 then
        return  {
          description = 'You are amazing.',
          image = image.apple
        }
      else
        return  {
          description = 'You are lame.',
          image = image.placeholder
        }
      end
    end
  }
}
