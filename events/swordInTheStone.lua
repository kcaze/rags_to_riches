require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Sword In The Stone",
    amount = 5,
    weight = 1,
    condition = function (state)
      return state.coins >= 5
    end,
    description = "You stumble across a small boulder that has a sword oddly wedged into it.",
    heads = {
      effectDescription = "Obtain 'Sword' (50%), -3 hp (50%)",
      effect = function (state)
        if love.math.random() <= 0.5 then
          table.insert(state.items, item.sword)
          return {
            description = "Huzzah! Despite your measly strength, you yanked on the sword a couple times and it comes loose!",
            image = image.sword
          }
        else
          state.hp = state.hp - 3
          return {
            description = "You pull really hard on the sword but just end up scratching yourself on its blade.",
            image = image.bad
          }
        end
    end
    },
    tails = {
      effectDescription = "+10 coins (75%)",
      effect = function (state)
        if love.math.random() <= 0.75 then
          state.coins = state.coins + 10
          return {
            description = 'You manage to lift the boulder into town and sell it to a local blacksmith for 10 coins.',
            image = image.plus10
          }
        else
          return {
            description = "You attempt to lift the boulder but to no avail!",
            image = image.shrug
          }
        end
      end
    },
    beg = {
      effectDescription = "+10 coins (5%)",
      effect = function (state)
        if love.math.random() <= 0.05 then
          state.coins = state.coins + 10
          return {
            description = 'You miraculously manage to lift the boulder into town and sell it to a local blacksmith for 10 coins.',
            image = image.plus10
          }
        else
          return {
            description = "You attempt to lift the boulder but to no one's surprise, the boulder doesn't budge.",
            image = image.shrug
          }
        end
    end
    }
}