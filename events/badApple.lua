require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Unwelcome guest",
    amount = 5,
    weight = 1.5,
    condition = function (state)
        return state.appleFestival > 0
    end,
    description = "An mysterious old woman attending the apple festival is demanding tribute.",
    heads = {
      effectDescription = "You don't have an apple. Fight the stranger",
      effect = function (state)
        state.appleFestival = state.appleFestival + 1
        if love.math.random() <= state.hp * 0.01 then
            return {
              description = "You handily win the fight. The stranger runs away.",
              image = image.stranger
            }
        else
            state.hp = state.hp - 10
            return {
              description = "You barely win the fight. You lose 10 HP. The stranger runs away.",
              image = image.stranger
            }
        end
    end
    },
    tails = {
      effectDescription = "You don't have an apple. Beg for your life",
      effect = function (state)
        state.appleFestival = state.appleFestival + 1
        state.hp = state.hp - 10
        return {
          description = 'The stranger hits you with a spell, but decides to spare your life. You lose 10 HP.',
          image = image.stranger
        }
    end
    },
    beg = {
      effectDescription = "Appease the stranger with an apple",
      effect = function (state)
        state.appleFestival = state.appleFestival + 1
        if table.contains(state.items, item.apple) then
            table.delete(state.items, item.apple)
            return {
              description = "The stranger is appeased. For now.",
              image = image.apple
            }
        else
            state.hp = state.hp - 100
            return {
              description = "The stranger puts you to eternal sleep.",
              image = image.stranger
            }
        end
    end
    }
}
