require('utils')
local items = require("../item");
local image = require("../image")

return {
    name = "Bake an apple pie",
    amount = 5,
    condition = function (state)
        return state.coins >= 5 and table.count(state.items, items.apple) >= 3 and state.appleFestival == 0
    end,
    description = "You have enough apples to bake an apple pie.",
    heads = {
      effectDescription = "Obtain 1 'Apple Pie' (requires 3 'Red Apple')",
      effect = function (state)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.insert(state.items, items.applePie)
        return {
          description = "You bake a warm apple pie.",
          image = image.applePie
        }
    end
    },
    tails = {
      effectDescription = "Explosion (-5 HP)",
      effect = function (state)
        state.hp = state.hp - 5
        return {
          description = 'As you heat up the oven, it explodes.',
          image = image.explosion
        }
    end
    },
    beg = {
      effectDescription = "Lose an 'Apple'",
      effect = function (state)
        table.delete(state.items, items.apple)
        return {
          description = 'You left it in the oven for too long! Your apple pie is burned to a crisp.',
          image = image.burntPie
        }
    end
    }
}
