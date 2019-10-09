local item = require("../item")
local image = require("../image")

return {
  name = "New Rat Dealer",
  amount = 25,
  weight = 0.5,
  condition = function (state)
    return state.coins >= 25 and state.ratLevel >= 2
  end,
  description = "You notice a person on the street. They could be a good potential rat dealer.",
  heads = {
    effectDescription = "+2 dealer (50%), +1 rat (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        table.insert(state.items, item.dealer)
        table.insert(state.items, item.dealer)
        return {
          description = [[You pitch like crazy to the person... and they are convinced. So convinced that they rope their friend into it too. You get 2 dealers.]],
          image = image.dealer,
        }
      else
        return {
          description = [[You pitch like crazy to the person... but they're not interested. They do hook you up with a rat though. ]],
          image = image.rat
        }
      end
    end
  },
  tails = {
    effectDescription = "+1 dealer (80%), ??? (20%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.8 then
        table.insert(state.items, item.dealer)
        return {
          description = [[You convince one person to join you as a dealer! Yay!]],
          image = image.dealer,
        }
      else
        if state.ratLevel == 2 then
          state.ratLevel = 3
          return {
            description = [[The person turns out to be a rat factory owner. Woah! He shows you how to make deals with rat factories. You advance to a rat dealmaker!]],
            image = image.factory
          }
        else
          table.insert(state.items, item.dealer)
          return {
            description = [[The person looks at you. "Wait, you're a rat dealmaker, isn't this beneath you?" He says... but is still convinced to join you.]],
            image = image.dealer
          }
        end
      end
    end
  },
  beg = {
    effectDescription = "-5 hp (75%) +1 rat (25%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.75 then
        state.hp = state.hp - 5
        return {
          description = [[You try to approach the person, but don't make it so far. A rat jumps out and bites you. You lose 5 hp.]],
          image = image.rat,
        }
      else
        table.insert(state.items, item.rat)
        return {
          description = [[The person leaves before you get there. A rat jumps out and into your arms. It's friendly.. and ready to be sold.]],
          image = image.rat,
        }
      end
    end
  }
}
