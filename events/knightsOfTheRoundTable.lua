require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "The Round Table",
    amount = 25,
    weight = 0.4,
    condition = function (state)
      return state.knightInvited and state.coins >= 25
    end,
    description = "You meet with your fellow knights at the round table to confer on what to do next.",
    heads = {
      effectDescription = "+50 coins, +10 hp",
      effect = function (state)
        state.coins = state.coins + 50
        state.hp = state.hp + 10
        return {
          description = "You decide to sell knight scouts cookies to fundraise for your cause. You fundraise 50 coins and a couple healing potions.",
          image = image.knightsOfTheRoundTable
        }
      end
    },
    tails = {
      effectDescription = "+100 coins (requires 'Sword' and 'Shield')",
      effect = function (state)
        if table.contains(state.items, item.sword) and table.contains(state.items, item.shield) then
          table.delete(state.items, item.sword)
          table.delete(state.items, item.shield)
          state.coins = state.coins + 100
          return {
            description = 'You decide to sell off some of your extra equipment and obtain 100 coins.',
            image = image.knightsOfTheRoundTable
          }
        else
          return {
            description = 'You propose selling off some of your extra equipment but you have none!',
            image = image.knightsOfTheRoundTableAngry
          }
        end
      end
    },
    beg = {
      effectDescription = "No effect",
      effect = function (state)
        return {
          description = 'You have no proposals and the other knights are angry at how useless you are!',
          image = image.knightsOfTheRoundTableAngry
        }
      end
    }
}