require('utils')
local items = require("../item");
local image = require("../image")

return {
    name = "Apple Pie Famous",
    amount = 25,
    condition = function (state)
        return state.coins >= 25 and table.contains(state.items, items.applePie) and state.appleFestival == 0
    end,
    description = "People from all corners of the globe travel to you upon hearing rumors of your legendary apple pie.",
    heads = {
      effectDescription = "Start an apple festival",
      effect = function (state)
        state.appleFestival = 1
        table.delete(state.items, item.applePie)
        return {
          description = "You suggest holding an apple festival. The gathering mob eats up your idea.",
          image = image.apple
        }
    end
    },
    tails = {
      effectDescription = "+50 coins (requires 'Apple Pie')",
      effect = function (state)
        state.coins = state.coins + 50
        table.delete(state.items, item.applePie)
        return {
          description = 'You sell your apple pie for a pretty 50 coins.',
          image = image.applePie
        }
    end
    },
    beg = {
      effectDescription = "+5 coins (requires 'Apple Pie')",
      effect = function (state)
        state.coins = state.coins + 5
        table.delete(state.items, item.applePie)
        return {
          description = 'A mob overwhelms you and they eat your apple pie. One kind soul tips you 5 coins for the pie.',
          image = image.bad
        }
    end
    }
}
