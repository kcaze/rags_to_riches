require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Knight's Invitation",
    amount = 5,
    weight = 1000,
    condition = function (state)
      return not state.knightInvited and state.coins >= 5
    end,
    description = "A knight in grimy armor stops you. \"You there, will you join our cause?\"",
    heads = {
      effectDescription = "+20 coins (requires 'Sword' and 'Shield')",
      effect = function (state)
        if table.contains(state.items, item.sword) and table.contains(state.items, item.shield) then
          state.coins = state.coins + 20
          state.knightInvited = true
          return {
            description = "\"Thank you, brother. This land is plagued with undead and we need to band together.\" He gives you 20 coins as initiation.",
            image = image.plus20
          }
        else
          return {
            description = "\"Brother, you look strong, but where is your sword and shield?!\"",
            image = image.knight
          }
        end
    end
    },
    tails = {
      effectDescription = "+10 coins",
      effect = function (state)
        state.coins = state.coins + 10
        return {
          description = 'You dupe the knight into first giving you 10 coins and promise to join the cause at a later date.',
          image = image.plus10
        }
    end
    },
    beg = {
      effectDescription = "+1 coin",
      effect = function (state)
        state.coins = state.coins + 1
        return {
          description = 'You have nothing to say. "Well take care brother. Here\'s a coin, go get yourself something to eat."',
          image = image.plus1
        }
    end
    }
}