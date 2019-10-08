require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Merlin",
    amount = 100,
    weight = 0.5,
    condition = function (state)
      return state.knightInvited and state.coins >= 100 and not table.contains(state.items, item.merlin)
    end,
    description = "You spot an interesting looking tower and knock on its door.",
    heads = {
      effectDescription = "Obtain 'Merlin' (requires 'Crystal Ball')",
      effect = function (state)
        if table.contains(state.items, item.crystalBall) then
          table.insert(state.items, item.merlin)
          return {
            description = "\"Ah perfect. This will surely help us against the undead.\", says Merlin as he joins you.",
            image = image.merlin
          }
        else
          return {
            description = "\"Look, I need the Crystal Ball. It's integral to solving the P=NP problem\"",
            image = image.shrug
          }
        end
      end
    },
    tails = {
      effectDescription = "+200 coins",
      effect = function (state)
        state.coins = state.coins + 200
        return {
          description = "A wizard opens the door. \"Look, I'm busy coding up my spells, take this and scram!\" He gives you 200 coins.",
          image = image.plus200
        }
      end
    },
    beg = {
      effectDescription = "+10 coin, +10 hp",
      effect = function (state)
        state.coins = state.coins + 10
        state.hp = state.hp + 10
        return {
          description = 'You spy a wizard through the window. Suddenly a spell is cast and you find 10 coins and recover 10 hp.',
          image = image.merlin
        }
      end
    }
}