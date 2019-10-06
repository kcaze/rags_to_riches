require('utils')
local items = require("../item");
local image = require("../image")

return {
    name = "Your apple pie",
    amount = 25,
    condition = function (state)
        return table.contains(state.items, items.applePie) and state.appleFestival == 0
    end,
    description = "People from all corners of the globe travel to you upon hearing rumors of your legendary apple pie.",
    heads = {
      effectDescription = "Hold an apple festival",
      effect = function (state)
        state.appleFestival = 1
        return {
          description = "You suggest holding an apple festival. The gathering mob is eats up your idea.",
          image = image.apple
        }
    end
    },
    tails = {
      effectDescription = "Sell your apple pie",
      effect = function (state)
        state.coins = state.coins + 50
        return {
          description = 'You sell your apple pie for a pretty 50 coins.',
          image = image.applePie
        }
    end
    },
    beg = {
      effectDescription = "The mob is overwhelmingly large...",
      effect = function (state)
        table.delete(state.items, items.applePie)
        return {
          description = 'The mob overwhelms you and they eat your apple pie.',
          image = image.bad
        }
    end
    }
}