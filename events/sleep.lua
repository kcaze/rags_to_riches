require('utils')
local image = require("../image")
local item = require("../item")

return {
  name = "You go to sleep.",
  amount = 1,
  description = "Sleeping 8 hours a day is good for you!",
  heads = {
    effectDescription = "+3 hp, ??? (requires 'Tooth')",
    effect = function (state)
      if table.contains(state.items, item.tooth)
        state.hp = state.hp + 3 
        state.coins = state.coins + 5 
        return {
          description = "Woosh! A tooth fairy appears and takes your tooth away. She leaves behind 5 coins as a result.",
          image = image.toothFairy
        }
      else
        state.hp = state.hp + 3 
        return {
          description = "You get a good night's sleep and regain 3 hp.",
          image = image.sleep
        }
      end
    end
  },
  tails = {
    effectDescription = "+3 hp, ??? (requires 'Tooth')",
    effect = function (state)
      if table.contains(state.items, item.tooth)
        state.hp = state.hp + 10
        return {
          description = "Woosh! A tooth fairy appears and takes your tooth away. She heals 10 of your hp in return.",
          image = image.toothFairy
        }
      else
        state.hp = state.hp + 3 
        return {
          description = "You get a good night's sleep and regain 3 hp.",
          image = image.sleep
        }
      end
    end
  },
  beg = {
    effectDescription = "+2 hp (50%), -1 hp (50%)",
    effect = function (state)
      if love.math.random() <= 0.5 then
        state.hp = state.hp + 2
        return {
          description = "You sleep soundly and regain 2 hp.",
          image = image.sleep
        }
      else
        state.hp = state.hp - 1
        return {
          description = "You toss and turn in your sleep as a nightmare haunts you and lose 1 hp.",
          image = image.placeholder
        }
      end
    end
  }
}
