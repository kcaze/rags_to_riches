require('utils')
local image = require("../image");
local items = require("../item")

return {
    name = "Bake an apple pie",
    amount = 10,
    condition = function (state)
       table.count(state.items, items.apple) >= 5
    end,
    description = "You have enough apples to bake an apple pie.",
    heads = {
      effectDescription = "Success (-5 apples, +1 apple pie)",
      effect = function (state)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.insert(state.items, items.applePie)
        return {
          description = "You bake a warm apple pie.",
          image = image.placeholder
        }
    end
    },
    tails = {
      effectDescription = "Explosion (-5 HP)",
      effect = function (state)
        state.hp = state.hp - 5
        return {
          description = 'As you heat up the oven, it explodes.',
          image = image.placeholder
        }
    end
    },
    beg = {
      effectDescription = "Failure (-5 apples)",
      effect = function (state)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        table.delete(state.items, items.apple)
        return {
          description = 'You left it in the oven for too long! Your apple pie is burned to a crisp.',
          image = image.placeholder
        }
    end
    }
}