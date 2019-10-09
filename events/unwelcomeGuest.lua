require('utils')
local item = require("../item");
local image = require("../image")

return {
    name = "Unwelcome Guest",
    amount = 5,
    weight = 1.5,
    condition = function (state)
        return state.appleFestival > 0
    end,
    description = "A mysterious old witch attending the apple festival is demanding tribute.",
    heads = {
      effectDescription = "+10 coins (requires 'Red Apple'), otherwise -3 hp",
      effect = function (state)
        state.appleFestival = state.appleFestival + 1
        if table.contains(state.items, item.apple) then
          table.delete(state.items, item.apple)
          state.coins = state.coins + 10
          return {
            description = "\"May... I... have an... apple?\" You hand one over and she pays you 10 coins.",
            image = image.plus10
          }
        else
            state.hp = state.hp - 3
            return {
              description = 'The witch hits you with a spell in frustration. You lose 3 hp.',
              image = image.stranger
            }
        end
    end
    },
    tails = {
      effectDescription = "+3 hp (requires 'Red Apple'), otherwise -10 hp",
      effect = function (state)
        state.appleFestival = state.appleFestival + 1
        if table.contains(state.items, item.apple) then
          table.delete(state.items, item.apple)
          state.hp = state.hp + 3
          return {
            description = 'The witch snacks on one of your apples and is kind enough to even restore 3 hp to you.',
            image = image.stranger
          }
        else
          state.hp = state.hp - 10
          return {
            description = 'The witch hits you with a spell, but decides to spare your life. You lose 10 hp.',
            image = image.stranger
          }
        end
    end
    },
    beg = {
      effectDescription = "No effect (requires 'Red Apple'), otherwise -100 hp",
      effect = function (state)
        state.appleFestival = state.appleFestival + 1
        if table.contains(state.items, item.apple) then
            table.delete(state.items, item.apple)
            return {
              description = "The witch is appeased with an apple. For now.",
              image = image.apple
            }
        else
            state.hp = state.hp - 100
            return {
              description = "The witch casts an eternal sleep spell on you, knocking out 100 hp.",
              image = image.stranger
            }
        end
    end
    }
}
