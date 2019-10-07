require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Sir Laire",
    amount = 25,
    weight = 0.75,
    condition = function (state)
      return state.knightInvited and state.coins >= 50 and not table.contains(state.items, item.sirLaire)
    end,
    description = "\"Praise the sun!\", you hear a knightly fellow shout. You curiously approach the knight.",
    heads = {
      effectDescription = "???",
      effect = function (state)
        if state.sunsPraised >= 5 then
          table.insert(state.items, item.sirLaire)
          return {
            description = "\"Ah you are truly a sun-praiser. Let us go fight the undead together and restore the sun's glory!\" Sir Laire decides to join you.",
            image = image.solaire
          }
        else
          return {
            description = "\"No.... we must praise the sun MORE! " .. state.sunsPraised .. " times is not enough...\", mutters the knight to himself as he shakes his head.",
            image = image.solaire
          }
        end
      end
    },
    tails = {
      effectDescription = "Praises the sun",
      effect = function (state)
        state.sunsPraised = state.sunsPraised + 1
        return {
          description = 'You raise your arms in a V shape and shout \"PRAISE THE SUN!\". The knight joins you in your sunny celebration.',
          image = image.solaire
        }
      end
    },
    beg = {
      effectDescription = "+3 hp (90%), -1 hp (10%)",
      effect = function (state)
        if love.math.random() <= 0.9 then
          state.hp = state.hp + 3
          return {
            description = 'The knight turns to you and shouts, \"PRAISE THE SUN!\". You feel a bit cheerier and regain 3 hp.',
            image = image.solaire
          }
        else
          state.hp = state.hp - 1
          return {
            description = 'The knight turns to you and shouts, \"PRAISE THE SUN!\". You recall a particularly nasty sunburn and lose 1 hp.',
            image = image.solaire
          }
        end
      end
    }
}