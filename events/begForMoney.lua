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
    effectDescription = "+5 coins (50%), -2 hp (50%)",
    effect = function (state)
      if love.math.random() <= 0.5 then
        state.coins = state.coins + 5
        return {
          description = "A wealthy merchant takes pity on you and decides to give you $5.",
          image = image.placeholder
        }
      else
        state.hp = state.hp - 2
        return {
          description = "You reach towards a wealthy merchant but, disgusted by your appearance, he kicks you.",
          image = image.placeholder
        }
      end
    end
  },
  tails = {
    effectDescription = "+3 coins (50%), +2 coin (50%)",
    effect = function (state)
      if love.math.random() <= 0.5 then
        state.coins = state.coins + 3
        return {
          description = "A passerby drops $3 into your hands. How lucky.",
          image = image.placeholder
        }
      else
        state.coins = state.coins + 2
        return {
          description = "A passerby drops $2 into your hands. Better than nothing.",
          image = image.placeholder
        }
      end
    end
  },
  beg = {
    effectDescription = "+1 coins (50%), -2 hp (50%)",
    effect = function (state)
      if love.math.random() <= 0.5 then
        state.coins = state.coins + 1
        return {
          description = "You are completely ignored, but you find $1 on the ground anyways.",
          image = image.placeholder
        }
      else
        state.hp = state.hp - 2
        return {
          description = "A drunken man is annoyed with your groveling and punches you in the face.",
          image = image.punch
        }
      end
    end
  }
}
