require('utils')
local image = require("../image");
local item = require("../item")

return {
  name = "Rummage",
  amount = 5,
  condition = function (state)
    return state.knightInvited and state.coins >= 10
  end,
  description = "You decide to rummage through the knights' storeroom.",
  heads = {
    effectDescription = "Obtain ??? (10%)",
    effect = function (state)
      if not table.contains(state.items, item.crystalBall) and love.math.random() <= 0.05 then
        table.insert(state.items, item.crystalBall)
        return {
          description = "You find a crystal ball. Who knew you had such an item in the storeroom!",
          image = image.crystalBall
        }
      else
        return {
          description = "You find nothing. Alas, c'est la vie.",  
          image = image.shrug
        }
      end
    end
  },
  tails = {
    effectDescription = "Obtain 3 'Red Apple' (75%)",
    effect = function (state)
      if love.math.random() <= 0.75 then
        table.insert(state.items, item.apple)
        table.insert(state.items, item.apple)
        table.insert(state.items, item.apple)
        return {
          description = "You find 3 apples. Now you can keep up to 3 doctors away a day!",
          image = image.apple
        }
      else
        return {
          description = "You find nothing. Alas, c'est la vie.",  
          image = image.shrug
        }
      end
    end
  },
  beg = {
    effectDescription = "+2 coins (50%)",
    effect = function (state)
      if love.math.random() <= 0.5 then
        state.coins = state.coins + 2
        return {
          description = "You find 2 coins on the ground. Yeah, you'll take it.",
          image = image.plus2
        }
      else
        return {
          description = "You find nothing. Alas, c'est la vie.",  
          image = image.shrug
        }
      end
    end
  }
}
