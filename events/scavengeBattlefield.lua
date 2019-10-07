require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Battlefield Scavenging",
    amount = 5,
    weight = 1,
    condition = function (state)
      return state.coins >= 5
    end,
    description = "You hear that last night the holy knights waged a war on the undead. Perhaps there are spoils to be had.",
    heads = {
      effectDescription = "Obtain 'Shield' (50%), +10 coins (50%)",
      effect = function (state)
        if love.math.random() <= 0.5 then
          table.insert(state.items, item.shield)
          return {
            description = "Sweet! You find a dead knight and pry off their shield. You wonder what happened to their sword though...",
            image = image.shield
          }
        else
          state.coins = state.coins + 10
          return {
            description = "You rummage through a cadaver's pockets and find 10 coins.",
            image = image.plus10
          }
        end
    end
    },
    tails = {
      effectDescription = "+15 coins (50%), -5 hp (50%)",
      effect = function (state)
        if love.math.random() <= 0.5 then
          state.coins = state.coins + 15
          return {
            description = "You rummage through a cadaver's pockets and find 15 coins. They're loaded!",
            image = image.plus15
          }
        else
          state.hp = state.hp - 5
          return {
            description = "You rummage through a cadaver's pockets when it suddenly springs to life and bites you for 5 hp!",
            image = image.bad
          }
        end
      end
    },
    beg = {
      effectDescription = "+1 coin",
      effect = function (state)
        state.coins = state.coins + 1
        return {
          description = 'You spot a coin at the edge of the battlefield, take it and scurry off.',
          image = image.plus1
        }
    end
    }
}