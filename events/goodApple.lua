require('utils')
local items = require("../item");
local image = require("../image")

return {
    name = "Apple Fight",
    amount = 5,
    weight = 1.5,
    condition = function (state)
        return state.appleFestival > 0
    end,
    description = "As part of the apple festival, people are throwing apples at each other.",
    heads = {
      effectDescription = "Obtain 3 'Red Apple'",
      effect = function (state)
        table.insert(state.items, items.apple)
        table.insert(state.items, items.apple)
        table.insert(state.items, items.apple)
        return {
          description = "The apples miss you and you pick 3 apples off of the ground.",
          image = image.apple
        }
    end
    },
    tails = {
      effectDescription = "Obtain 1 'Red Apple'",
      effect = function (state)
        table.insert(state.items, items.apple)
        state.happiness = state.happiness + 1
        return {
          description = 'You catch an apple in midair as it flies towards you. Sweet!',
          image = image.apple
        }
    end
    },
    beg = {
      effectDescription = "-5 hp",
      effect = function (state)
        state.hp = state.hp - 5
        return {
          description = 'A stray apple clonks you in the noggin and you lose 5 HP.',
          image = image.appleHit
        }
    end
    }
}