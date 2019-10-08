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
    effectDescription = "Showdown (Chance of victory: # of apples * 10%)",
    effect = function (state)
      if love.math.random() <= table.count(state.items, item.apple) * 0.01 then
        state.appleFestival = state.appleFestival + 1
        return {
          description = "After a long, grueling fight, you throw one last apple at the stranger to knock out the last of her HP. After the fight, the Apple Fairy appears to thank you for removing the apple scourge. You become the Apple King.",
          image = image.apple,
          win = true
        }
      else
        state.hp = state.hp - 100
        return {
          description = "You lose D:",
          image = image.stranger
        }
      end
    end
  },
  tails = {
    effectDescription = "Prepare apples for showdown (+? apples)",
    effect = function (state)
      if love.math.random() <= 0.3 then
        table.insert(state.items, item.apple)
        table.insert(state.items, item.apple)
        table.insert(state.items, item.apple)
        return {
          description = "You scrounge together 3 more apples.",
          image = image.apple
        }
      else
        if love.math.random() <= 0.5 then
          table.insert(state.items, item.apple)
          table.insert(state.items, item.apple)
          return {
            description = "You find 2 more apples lying around.",
            image = image.apple
          }
        else
          table.insert(state.items, item.apple)
          return {
            description = "A festival goer generously hands you an apple.",
            image = image.apple
          }
        end
      end
    end
  },
  beg = {
    effectDescription = "Chicken out (-1 apple)",
    effect = function (state)
      if table.contains(state.items, item.apple) then
        table.delete(state.items, item.apple)
        return {
          description = "You lose an apple while you're dallying around.",
          image = image.bad
        }
      else
        state.coins = state.coins - 1
        return {
          description = "You lose a coin while you're dallying around.",
          image = image.bad
        }
      end
    end
  }
}
