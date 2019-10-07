require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Undead Eradication",
    amount = 1000,
    weight = 0.2,
    condition = function (state)
      local recruited = 0
      if table.contains(state.items, item.merlin) then
        recruited = recruited + 1
      end
      if table.contains(state.items, item.ladyOfTheLake) then
        recruited = recruited + 1
      end
      if table.contains(state.items, item.sirLaire) then
        recruited = recruited + 1
      end
      return state.knightInvited and state.coins >= 1000 and recruited >= 2
    end,
    description = "The undead are growing stronger day by day and something must be done. This is it, you must eradicate them.",
    heads = {
      effectDescription = "Win (requires 'Lady of the Lake', 'Sir Laire' and 'Merlin')",
      effect = function (state)
        if table.contains(state.items, item.merlin) and table.contains(state.items, item.ladyOfTheLake) and table.contains(state.items, item.sirLaire) then
          return {
            description = "You did it. The land is free from the shadows of the undead. The people crown you as King Arthur and your job here is done.",
            win=true,
            image = image.crown
          }
        else
          return {
            description = "You expend a lot of forces to fight the undead but ultimately you weren't able to fully eradicate them.",
            image = image.bad
          }
        end
    end
    },
    tails = {
      effectDescription = "+1500 coins, +20 hp",
      effect = function (state)
        state.coins = state.coins + 1500
        state.hp = state.hp + 20
        return {
          description = 'You make some progress and your efforts are recognized by the people. You get 1500 coins and recover 20 hp.',
          image = image.good
        }
    end
    },
    beg = {
      effectDescription = "-15 hp",
      effect = function (state)
        state.hp = state.hp - 15
        return {
          description = 'The attack failed spectacularly and you are grievously injured in the process.',
          image = image.bad
        }
    end
    }
}