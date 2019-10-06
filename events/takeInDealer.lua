local rat = require("../items/rat");
local dealer = require("../items/dealer");
local image = require("../image")

return {
  name = "Take in a new rat dealer",
  amount = 25,
  weight = 0.5,
  condition = function (state)
    return state.coins >= 25 and state.ratLevel == 2
  end,
  description = "You notice a person on the street. They could be a good potential rat dealer.",
  heads = {
    effectDescription = "+2 dealer (50%), +1 rat (50%)",
    effect = function (state)
      local p = love.math.random()
      if p < 0.5 then
        state.ratsSold = state.ratsSold + 8
        table.insert(state.items, dealer)
        table.insert(state.items, dealer)
        return {
          description = [[You pitch like crazy to the person... and they are convinced. So convinced that they rope their friend into it too. You get 2 dealers.]],
          image = image.placeholder,
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
        state.ratsSold = state.ratsSold + 4
        table.insert(state.items, dealer)
        return {
          description = [[You convince one person to join you as a dealer! Yay!]],
          image = image.placeholder,
        }
      else
        state.ratLevel = 3
        return {
          description = [[The person turns out to be a rat provider. Woah! He shows you how to make rat provider deals. You advance to a rat dealmaker!]],
          image = image.rat
        }
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
        table.insert(state.items, rat)
        return {
          description = [[The person leaves before you get there. A rat jumps out and into your arms. It's friendly.. and ready to be sold.]],
          image = image.rat,
        }
      end
    end
  }
}
