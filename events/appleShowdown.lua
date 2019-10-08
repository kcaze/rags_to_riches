require('utils')
local item = require("../item");
local image = require("../image")

return {
  name = "Showdown",
  amount = 25,
  weight = 1.5,
  condition = function (state)
    return state.appleFestival > 5
  end,
  description = "The mysterious old woman has terrorized your apple festival for long enough. You're going to take her down.",
  heads = {
    effectDescription = "Win (# of 'Red Apple' * 10%), otherwise -25 hp",
    effect = function (state)
      if love.math.random() <= table.count(state.items, item.apple) * 0.1 then
        state.appleFestival = state.appleFestival + 1
        return {
          description = "After a long, grueling fight, you throw one last apple at the stranger to knock out the last of her HP. After the fight, the Apple Fairy appears to thank you for removing the apple scourge. You become the Apple King.",
          image = image.apple,
          win = true
        }
      else
        state.hp = state.hp - 25
        return {
          description = "You lose the fight and take 25 hp.",
          image = image.stranger
        }
      end
    end
  },
  tails = {
    effectDescription = "Obtain 3 'Red Apple' (30%), obtain 2 'Red Apple' (20%), obtain 'Red Apple' (50%)",
    effect = function (state)
      if love.math.random() <= 0.3 then
        table.insert(state.items, items.apple)
        table.insert(state.items, items.apple)
        table.insert(state.items, items.apple)
        return {
          description = "You scrounge together 3 more apples.",
          image = image.apple
        }
      else
        if love.math.random() <= 0.5 then
          table.insert(state.items, items.apple)
          table.insert(state.items, items.apple)
          return {
            description = "You find 2 more apples lying around.",
            image = image.apple
          }
        else
          table.insert(state.items, items.apple)
          return {
            description = "A festival goer generously hands you an apple.",
            image = image.apple
          }
        end
      end
    end
  },
  beg = {
    effectDescription = 'Lose 1 "Red Apple" and -1 coin',
    effect = function (state)
      if table.contains(state.items, item.apple) then
        table.delete(state.items, item.apple)
      end
      return {
        description = "You lose chicken out and lose an apple and 1 coin while you're dallying around.",
        image = image.bad
      }
    end
  }
}
